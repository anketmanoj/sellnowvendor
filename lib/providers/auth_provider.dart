import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class AuthProvider extends ChangeNotifier {
  late File image;
  bool isPicAvail = false;
  String pickerError = '';
  double? shopLatitude;
  double? shopLongitude;
  late String shopAddress;
  late String placeName;
  String error = "";

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      this.image = File(pickedFile.path);
      notifyListeners();
      this.isPicAvail = true;
      notifyListeners();
    } else {
      this.isPicAvail = false;
      notifyListeners();
      this.pickerError = "no image selected";
      print("No image selected");
      notifyListeners();
    }
    return this.image;
  }

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    this.shopLatitude = _locationData.latitude;
    this.shopLongitude = _locationData.longitude;
    notifyListeners();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var shopAddress = _addresses.first;
    this.shopAddress = shopAddress.addressLine!;
    this.placeName = shopAddress.featureName!;
    notifyListeners();
    return shopAddress;
  }

  Future<UserCredential?> registerVendor(email, password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.error = 'The password provided is too weak.';
        notifyListeners();
      } else if (e.code == 'email-already-in-use') {
        this.error = 'The account already exists for that email.';
        notifyListeners();
      }
    } catch (e) {
      this.error = e.toString();
      notifyListeners();
      print(e.toString());
    }
    return userCredential;
  }

  Future<void> saveVendorDataToDb(
      {String? url,
      String? shopName,
      String? mobile,
      String? description,
      String? address,
      String? email}) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference _vendors =
        FirebaseFirestore.instance.collection('vendors').doc(user!.uid);

    _vendors.set({
      'uid': user.uid,
      'shopName': shopName,
      'mobile': mobile,
      'description': description,
      'email': email,
      'address': "${this.placeName}: ${this.shopAddress}",
      'location': GeoPoint(this.shopLatitude!, this.shopLongitude!),
      'shopOpen': true,
      'rating': 0.0,
      'totalRating': 0.0,
      'isTopPicked': true,
      'shopProfilePic': url,
    });
    return null;
  }
}
