import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class TodoFormController extends State<TodoFormView> {
  static late TodoFormController instance;
  late TodoFormView view;

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
  String? title;
  String? status;

  doSave() async {
    await FirebaseFirestore.instance.collection("todos").add({
      "title": title,
      "status": status,
      "created_at": Timestamp.now(),
      "user": {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "username": FirebaseAuth.instance.currentUser!.displayName,
        "email": FirebaseAuth.instance.currentUser!.email,
      }
    });
    Get.back();
  }
}
