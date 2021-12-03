import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/screens/homepage.dart';
import 'package:shopping/screens/loginservices/loginpage.dart';

class Authinitication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? userUid;
  String? get getuserUid => userUid;
  Stream<User?> get authstatechange => firebaseAuth.authStateChanges();
  Future loginaccount(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      userUid = user?.uid;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future createaccount(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      userUid = user?.uid;
      print(userUid);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future forgerpassword(BuildContext context, String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(snackBar);
    }
  }

  Future logout(
    BuildContext context,
  ) async {
    try {
      await firebaseAuth.signOut().whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Loginpage()),
            (route) => false);
      });
    } catch (e) {}
  }
}
