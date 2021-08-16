import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_now_vendor/providers/auth_provider.dart';
import 'package:sell_now_vendor/screens/homeScreen.dart';
import 'package:sell_now_vendor/widgets/reset_password.dart';

class LogoinScreen extends StatefulWidget {
  const LogoinScreen({Key? key}) : super(key: key);
  static const String id = "login-screen";

  @override
  _LogoinScreenState createState() => _LogoinScreenState();
}

class _LogoinScreenState extends State<LogoinScreen> {
  final _formKey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  Icon? icon;
  bool _visibile = false;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/logo.gif',
                            height: 220,
                          ),
                        ],
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          final bool _isValid = EmailValidator.validate(
                              _emailTextController.text);
                          if (!_isValid) {
                            return "Invalid Email";
                          }
                          return null;
                        },
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          focusColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          if (value.length < 6) {
                            return "Passowrd must be atleast 6 Characters long";
                          }
                          return null;
                        },
                        controller: _passwordTextController,
                        obscureText: _visibile ? false : true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _visibile = !_visibile;
                              });
                            },
                            icon: Icon(_visibile == true
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          focusColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  _authData
                                      .loginVendor(_emailTextController.text,
                                          _passwordTextController.text)
                                      .then(
                                    (credential) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      if (credential?.user?.uid != null) {
                                        Navigator.pushReplacementNamed(
                                            context, HomeScreen.id);
                                      } else {
                                        setState(() {
                                          _loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("User doesnt exist"),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    child: Text("Register"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("Invalid Email or Password"),
                                    ),
                                  );
                                }
                              },
                              child: _loading == false
                                  ? Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  : Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ResetPassword.id);
                        },
                        child: Text(
                          "Forgot Password ? ",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
