import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  Widget build(context, DashboardController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text("Dashboard"),
          actions: [
            IconButton(
              onPressed: () => controller.doLogout(),
              icon: const Icon(Icons.logout),
            ),
            const SizedBox(width: 20)
          ]),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(FirebaseAuth
                          .instance.currentUser!.photoURL ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdCzHV07eVufgUb8pwc7lAIkVxLZlnWF76WQ&s"),
                ),
                title: Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? "User"),
                subtitle: Text(
                    FirebaseAuth.instance.currentUser!.email ?? "email.com"),
                trailing: const Icon(Icons.done, color: Colors.green),
              ),
            ),
            const SizedBox(height: 30),
            CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  controller.imagePath ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvC4AUcEhv3MWotG-5AdzLqokoewCVH680QCiYn1yzuZeVOk71f_kJ2MsE9gIlq1faBLw&usqp=CAU",
                )),
            const SizedBox(height: 20),
            QButton(
                onPressed: () => controller.getImage(),
                child: const Text(
                  "Upload",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            const SizedBox(height: 20),
            QButton(
                onPressed: () => controller.tap(),
                child: const Text("Get Image")),
            // Text(FirebaseStorage.instance.app.name.length.toString()),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: controller.imageUrls.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(controller.imageUrls[index]),
                    ),
                  );
                },
              ),
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
          onPressed: () => Get.to(const TodoListView()),
          backgroundColor: const Color(0xff5A7BFA),
          child: const Icon(Icons.add, color: Colors.white)),
    );
  }

  @override
  State<DashboardView> createState() => DashboardController();
}
