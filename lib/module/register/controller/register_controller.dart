import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class RegisterController extends State<RegisterView> {
  static late RegisterController instance;
  late RegisterView view;

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
  late UserCredential userCredential;
  String? username;
  String? email;
  String? password;

  doRegister() async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "username": userCredential.user!.displayName,
        "email": email,
      });
      Get.offAll(const DashboardView());
      showSnackBar("Akun Berhasil Didaftarkan");
    } catch (e) {
      showSnackBar("Email sudah terdaftar");
    }
  }
}
