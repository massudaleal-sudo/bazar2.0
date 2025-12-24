import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bazar_app/pages/vendedor/admin/admin_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA-pN6eULs3mUE5r5A4JYbfKPKdhhw8Hug",
      authDomain: "bazar-9e2f3.firebaseapp.com",
      projectId: "bazar-9e2f3",
      storageBucket: "bazar-9e2f3.appspot.com",
      messagingSenderId: "501068397244",
      appId: "1:501068397244:web:46dbb236c4e6e4b1",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminHomePage(),
    );
  }
}
