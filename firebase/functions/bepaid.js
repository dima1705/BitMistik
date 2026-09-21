const functions = require("firebase-functions");
const admin = require("firebase-admin");

function getCredentials() {
  const cfg = (functions.config && functions.config().bepaid) || {};
  return {
    shopId: process.env.BEPAID_SHOP_ID || cfg.shop_id || "",
    secretKey: process.env.BEPAID_SECRET_KEY || cfg.secret_key || "",
    test:
      String(process.env.BEPAID_TEST || cfg.test || "false").toLowerCase() ===
      "true",
    currency: process.env.BEPAID_CURRENCY || cfg.currency || "BYN",
  };
}

function authHeader(shopId, secretKey) {
  return "Basic " + Buffer.from(`${shopId}:${secretKey}`).toString("base64");
}

async function bePaidRequest(method, path, body) {
  const { shopId, secretKey } = getCredentials();
  if (!shopId || !secretKey) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "bePaid shop credentials are not configured.",
    );
  }

  const response = await fetch(`https://checkout.bepaid.by${path}`, {
    method,
    headers: {
      Authorization: authHeader(shopId, secretKey),
      "Content-Type": "application/json",
      Accept: "application/json",
      "X-API-Version": "2",
    },
    body: body ? JSON.stringify(body) : undefined,
  });

  const data = await response.json().catch(() => ({}));
  if (!response.ok) {
    const message =
      data.message ||
      data.error ||
      `bePaid request failed with status ${response.status}`;
    const error = new Error(message);
    error.details = data;
    throw error;
  }
  return data;
}

function isSuccessfulCheckout(payload) {
  const checkout = payload && payload.checkout;
  if (!checkout) {
    return false;
  }
  const status = String(checkout.status || "").toLowerCase();
  const paymentStatus = String(
    (((checkout.gateway_response || {}).payment || {}).status) || "",
  ).toLowerCase();
  return status === "successful" || paymentStatus === "successful";
}

async function creditIfNeeded(token, checkoutPayload) {
  const db = admin.firestore();
  const ref = db.collection("bepaid_checkouts").doc(token);
  return db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    if (data.credited) {
      return { success: true, already: true, paymentId: data.paymentId || null };
    }

    const uid = data.uid;
    const amount = Number(data.amount || 0);
    const amountUsd = Number(data.amountUsd || data.amount_usd || 0);
    const rate = Number(data.rate || 0);
    if (!uid || amount <= 0) {
      return { success: true, credited: false };
    }

    const userRef = db.collection("users").doc(uid);
    const userSnap = await tx.get(userRef);
    const currentBalance = Number((userSnap.data() || {}).balance || 0);
    const crystals = rate > 0 ? Math.floor(amount / rate) : 0;
    const newBalance = currentBalance + crystals;
    const transferAmount = amountUsd > 0 ? amountUsd : amount;

    const paymentRef = db.collection("payments").doc();
    tx.set(paymentRef, {
      user: userRef,
      transfer_amount: transferAmount,
      transfer_type: "Пополнение счета · bePaid",
      balance: newBalance,
      balance_is_after: true,
      converted: rate > 0 ? amount / rate : 0,
      rate: rate,
      amount_byn: amount,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
      bepaid_token: token,
    });
    tx.update(userRef, { balance: newBalance });
    tx.set(
      ref,
      {
        credited: true,
        paymentId: paymentRef.id,
        status: "successful",
        gateway: checkoutPayload || {},
        credited_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );
    return { success: true, paymentId: paymentRef.id };
  });
}

exports.createBePaidCheckout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Sign in required.",
    );
  }

  const amount = Number(data.amount || 0);
  if (!amount || amount < 1) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Minimum top-up amount is 1.",
    );
  }

  const credentials = getCredentials();
  const amountMinor = Math.round(amount * 100);
  const trackingId =
    data.trackingId || `${context.auth.uid}_${Date.now()}`;
  const amountUsd = Number(data.amountUsd || data.amount_usd || 0);
  // Gateway always settles in BYN; UI amounts stay in USD.
  const chargeCurrency = "BYN";

  const payload = {
    checkout: {
      transaction_type: "payment",
      attempts: 3,
      iframe: true,
      test: credentials.test,
      duplicate_check: false,
      order: {
        amount: amountMinor,
        currency: chargeCurrency,
        description: data.description || "Пополнение баланса bitMystic",
        tracking_id: trackingId,
      },
      settings: {
        language: "ru",
        success_url: "https://bitmystic.app/bepaid/success",
        fail_url: "https://bitmystic.app/bepaid/fail",
        decline_url: "https://bitmystic.app/bepaid/decline",
        cancel_url: "https://bitmystic.app/bepaid/cancel",
        notification_url:
          "https://us-central1-bitmystic-1.cloudfunctions.net/bepaidNotification",
      },
      payment_method: {
        types: ["credit_card"],
      },
    },
  };

  if (data.email) {
    payload.checkout.customer = { email: data.email };
  }

  const result = await bePaidRequest("POST", "/ctp/api/checkouts", payload);
  const token = result.checkout && result.checkout.token;
  if (token) {
    await admin
      .firestore()
      .collection("bepaid_checkouts")
      .doc(token)
      .set({
        uid: context.auth.uid,
        amount,
        amountUsd: amountUsd > 0 ? amountUsd : null,
        rate: Number(data.rate || 0),
        currency: chargeCurrency,
        trackingId,
        credited: false,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });
  }

  return {
    token,
    redirect_url: result.checkout && result.checkout.redirect_url,
  };
});

exports.confirmBePaidCheckout = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Sign in required.",
    );
  }
  const token = data.token;
  if (!token) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "token is required.",
    );
  }

  const payload = await bePaidRequest("GET", `/ctp/api/checkouts/${token}`);
  if (!isSuccessfulCheckout(payload)) {
    return { success: false, status: (payload.checkout || {}).status || "pending" };
  }
  return creditIfNeeded(token, payload);
});

exports.bepaidNotification = functions.https.onRequest(async (req, res) => {
  try {
    const body = req.body || {};
    const token =
      (body.checkout && body.checkout.token) ||
      req.query.token ||
      "";
    if (token && isSuccessfulCheckout(body)) {
      await creditIfNeeded(token, body);
    } else if (token) {
      const payload = await bePaidRequest(
        "GET",
        `/ctp/api/checkouts/${token}`,
      );
      if (isSuccessfulCheckout(payload)) {
        await creditIfNeeded(token, payload);
      }
    }
    res.status(200).send("ok");
  } catch (error) {
    console.error("bepaidNotification", error);
    res.status(200).send("ok");
  }
});
