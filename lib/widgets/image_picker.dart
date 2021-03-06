import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_now_vendor/providers/auth_provider.dart';

class ShopPicCard extends StatefulWidget {
  const ShopPicCard({Key? key}) : super(key: key);

  @override
  _ShopPicCardState createState() => _ShopPicCardState();
}

class _ShopPicCardState extends State<ShopPicCard> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          print("isPicAvail = ${_authData.isPicAvail}");
          _authData.getImage().then((image) {
            setState(() {
              _image = image;
            });
            if (image != null) {
              print("isPicAvail = ${_authData.isPicAvail}");
              setState(() {
                _authData.isPicAvail = true;
              });
            }
            print(_image!.path);
          });
        },
        child: SizedBox(
          height: 150,
          width: 150,
          child: Card(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: _image == null
                ? Center(
                    child: Text(
                      "Add Shop Image",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Image.file(
                    _image!,
                    fit: BoxFit.fill,
                  ),
          )),
        ),
      ),
    );
  }
}
