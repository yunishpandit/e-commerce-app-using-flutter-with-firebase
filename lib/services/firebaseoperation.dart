import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/authintication.dart';

class Firebaseoperation with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  Future createuser(
    BuildContext context,
    dynamic data,
  ) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(Provider.of<Authinitication>(context, listen: false).getuserUid)
        .set(data);
  }

  Future cartitems(BuildContext context, dynamic data, String name) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(Provider.of<Authinitication>(context, listen: false).getuserUid)
        .collection("carts")
        .doc(name)
        .set(data);
  }

  Future favoriteitems(BuildContext context, dynamic data, String name) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(Provider.of<Authinitication>(context, listen: false).getuserUid)
        .collection("favoriteitems")
        .doc(name)
        .set(data);
  }
}
