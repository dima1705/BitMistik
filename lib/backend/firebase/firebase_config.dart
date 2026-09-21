import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAxz_x7Mulz7KVoTTeTNlK8Y_fUNjPuWME",
            authDomain: "bitmystic-1.firebaseapp.com",
            projectId: "bitmystic-1",
            storageBucket: "bitmystic-1.firebasestorage.app",
            messagingSenderId: "339658680310",
            appId: "1:339658680310:web:4761ecf1f5a416237509d7",
            measurementId: "G-H53WHVLTG1"));
  } else {
    await Firebase.initializeApp();
  }
}
