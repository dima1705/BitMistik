/// Credentials for bePaid Checkout.
///
/// Shop: bitMystick (id 34475).
/// Fill [secretKey] from the bePaid backoffice
/// (Магазины → Подробнее → Учетные данные), or pass at build time:
/// `--dart-define=BEPAID_SECRET_KEY=...`
///
/// Alternatively store `shop_id`, `secret_key`, `test`, `currency`
/// in Firestore document `app_config/bepaid`.
class BePaidConfig {
  BePaidConfig._();

  static const shopName = 'bitMystick';

  static const shopId = String.fromEnvironment(
    'BEPAID_SHOP_ID',
    defaultValue: '34475',
  );

  static const secretKey = String.fromEnvironment(
    'BEPAID_SECRET_KEY',
    defaultValue:
        'e26a57b0b167e8f5f67f815f424e589e1d345f7a7de3fcb1ee2f745af9f008ea',
  );

  static const testMode = bool.fromEnvironment(
    'BEPAID_TEST',
    defaultValue: false,
  );

  static const currency = String.fromEnvironment(
    'BEPAID_CURRENCY',
    defaultValue: 'BYN',
  );

  static const checkoutHost = 'checkout.bepaid.by';
  static const successPath = '/bepaid/success';
  static const failPath = '/bepaid/fail';
  static const declinePath = '/bepaid/decline';
  static const cancelPath = '/bepaid/cancel';

  static const successUrl = 'https://bitmystic.app$successPath';
  static const failUrl = 'https://bitmystic.app$failPath';
  static const declineUrl = 'https://bitmystic.app$declinePath';
  static const cancelUrl = 'https://bitmystic.app$cancelPath';
  static const notificationUrl =
      'https://us-central1-bitmystic-1.cloudfunctions.net/bepaidNotification';

  static bool get hasClientCredentials =>
      shopId.isNotEmpty &&
      secretKey.isNotEmpty &&
      shopId != 'YOUR_SHOP_ID';
}
