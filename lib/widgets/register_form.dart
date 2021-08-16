import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_now_vendor/providers/auth_provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  var _emailTextcontroller = TextEditingController();
  var _phoneTextcontroller = TextEditingController();
  var _businessNameTextcontroller = TextEditingController();
  var _businessDescTextcontroller = TextEditingController();
  var _passwordTextcontroller = TextEditingController();
  var _cPasswordTextcontroller = TextEditingController();
  var _addressTextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _businessNameTextcontroller,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Shop Name";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.add_business),
                labelText: "Business Name",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _phoneTextcontroller,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Mobile Number";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone_android),
                labelText: "Mobile Number",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailTextcontroller,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Email";
                }
                final bool _isValid =
                    EmailValidator.validate(_emailTextcontroller.text);
                if (!_isValid) {
                  return "Invalid Email";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: "Email",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordTextcontroller,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Password";
                }
                if (value.length < 6) {
                  return "Passowrd must be atleast 6 Characters long";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password_outlined),
                labelText: "Password",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _cPasswordTextcontroller,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Confirm Password";
                }
                if (_passwordTextcontroller.text !=
                    _cPasswordTextcontroller.text) {
                  return "Passwords Dont Match";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: "Confirm Password",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 6,
              controller: _addressTextcontroller,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Press Navigation Button";
                }
                if (_authData.shopLatitude == null) {
                  return "Please press Navigation Button";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.contact_mail_outlined),
                labelText: "Business Address",
                suffixIcon: IconButton(
                  onPressed: () {
                    _addressTextcontroller.text = "Locating...";
                    _authData.getCurrentAddress().then((address) {
                      if (address != null) {
                        setState(() {
                          _addressTextcontroller.text =
                              "${_authData.placeName}, ${_authData.shopAddress}";
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Couldnt Find Location")));
                      }
                    });
                  },
                  icon: Icon(
                    Icons.location_searching_outlined,
                  ),
                ),
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _businessDescTextcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.description_outlined),
                labelText: "Business Description",
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              final _authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              if (_authProvider.isPicAvail == true) {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Processing Data")));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Shop Profile Picture is Missing")));
                print(_authProvider.isPicAvail);
              }
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
