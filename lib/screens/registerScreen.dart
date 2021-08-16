import 'package:flutter/material.dart';
import 'package:sell_now_vendor/widgets/image_picker.dart';
import 'package:sell_now_vendor/widgets/register_form.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = "register-screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ShopPicCard(),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
