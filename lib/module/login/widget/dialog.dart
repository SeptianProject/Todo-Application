import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

showAlertDialog(
  String title,
  String content,
  void Function()? onPressedTrue,
) {
  showDialog(
      context: globalContext,
      builder: (globalContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("Batal")),
            TextButton(onPressed: onPressedTrue, child: const Text("Baiklah")),
          ],
        );
      });
}
