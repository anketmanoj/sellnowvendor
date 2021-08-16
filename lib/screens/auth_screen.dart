import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const String id = "auth-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Auth Screen"),
      ),
    );
  }
}
