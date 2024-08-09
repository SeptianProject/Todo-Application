import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class TodoListController extends State<TodoListView> {
  static late TodoListController instance;
  late TodoListView view;

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

  int selectedIndex = 0;

  updateTodo(Map<String, dynamic> item) async {
    var title = item["title"];
    title ??= "Belum diisi";
    var status = item["status"];
    if (status == "Pending" || status == null) {
      status = "Ongoing";
    } else if (status == "Ongoing") {
      status = "Done";
    } else {
      status = "Pending";
    }
    await FirebaseFirestore.instance
        .collection("todos")
        .doc(item["id"])
        .update({
      "title": title,
      "status": status,
    });
  }

  deleteTodo(Map<String, dynamic> item) async {
    await FirebaseFirestore.instance
        .collection("todos")
        .doc(item["id"])
        .delete();

    return showSnackBar("Berhasil menghapus ${item["title"]}");
  }
}
