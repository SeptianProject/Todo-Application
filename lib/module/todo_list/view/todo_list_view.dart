import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  Widget build(context, TodoListController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("TodoList"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("todos").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Text("Error");
                if (snapshot.data == null) return Container();
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Data"));
                }
                final data = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item =
                        (data.docs[index].data() as Map<String, dynamic>);
                    item["id"] = data.docs[index].id;
                    var createAt = item["created_at"];
                    var date = (createAt as Timestamp).toDate();
                    var hourFormat = DateFormat("H.m").format(date);
                    var dayFormat = DateFormat().add_EEEE().format(date);

                    Color? color = Colors.amber[700];
                    if (item["status"] == "Ongoing") {
                      color = Colors.blue;
                    } else if (item["status"] == "Done") {
                      color = Colors.green;
                    }

                    return Dismissible(
                      key: Key(item["id"]),
                      onDismissed: (direction) => controller.deleteTodo(item),
                      child: Card(
                        child: ListTile(
                          onTap: () => controller.updateTodo(item),
                          title: Text(item["title"]),
                          subtitle: Text("Waktu : $hourFormat - $dayFormat"),
                          trailing: Text(
                            item["status"],
                            style: TextStyle(
                                color: color,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: controller.selectedIndex,
        onZero: () => Get.to(const TodoListView()),
        onFirst: () => Get.to(const DashboardView()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () => Get.to(const TodoFormView()),
          backgroundColor: const Color(0xff5A7BFA),
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  @override
  State<TodoListView> createState() => TodoListController();
}
