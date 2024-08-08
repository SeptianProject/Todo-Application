import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/core.dart';

class LoginController extends State<LoginView> {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    super.initState();
    instance = this;
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  void onReady() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? email;
  String? password;

  doLoginEmail() async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email!, password: password!);
      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "username": userCredential.user!.displayName,
        "email": userCredential.user!.email,
      });
      Get.offAll(const DashboardView());
      showSnackBar("Akun Berhasil Login");
    } catch (err) {
      showSnackBar("Email atau password salah");
    }
  }

  doLoginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      await googleSignIn.disconnect();
    } catch (err) {
      log(err.toString());
    }

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("userCredential: $userCredential");
      Get.offAll(const DashboardView());
    } catch (err) {
      showSnackBar("Akun Google sudah digunakan");
    }
  }

  doLoginAnonymous() async {
    await FirebaseAuth.instance.signInAnonymously();
    Get.offAll(const DashboardView());
  }
}
