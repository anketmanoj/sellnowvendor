import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sell_now_vendor/screens/loginScreen.dart';
import 'package:sell_now_vendor/screens/registerScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = "home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, LogoinScreen.id);
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
