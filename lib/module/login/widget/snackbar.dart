import 'package:flutter/material.dart';
import 'package:todo_app/state_util.dart';

showSnackBar(String message) {
  ScaffoldMessenger.of(globalContext).showSnackBar(
    SnackBar(
      content: Center(
          child: Text(
        message,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      )),
    ),
  );
}
