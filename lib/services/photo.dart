import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserPhoto {
  final _auth = FirebaseAuth.instance;
  uploadphoto(BuildContext context, imageurl, String name) async {
    final firestore = FirebaseFirestore.instance.collection('users');
    var user = _auth.currentUser;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref('${user!.email!}Profile$id');
    UploadTask uploadTask = reference.putFile(imageurl);

    await Future.value(uploadTask).then((value) async {
      var newUrl = await reference.getDownloadURL();
      firestore
          .doc(user.uid)
          .set({'profile-pic': newUrl.toString()}, SetOptions(merge: true));
    }).onError((error, stackTrace) {
      // PopUpMessages.flushBarErrorMessage(error.toString(), context);
      print("Bhayeba Upload");
    });
  }

  adduserdetails(BuildContext context, String first, String last,
      String address, String phonenumber, String dob, String aboutme) {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Products');
    ref.doc(user!.uid).set({
      'first-name': first,
      'last-name': last,
      'address': address,
      'phone-number': phonenumber,
      'dob': dob,
      'about-me': aboutme,
      'profile-pic': '',
      'set-profile': true,
    }, SetOptions(merge: true)).then((value) {
      print("Bhayena add");
      // Navigator.pushReplacementNamed(context, RouteName.homeview);
      // PopUpMessages.snackBar("Your Profile is ready.", context);
    });
  }
}
