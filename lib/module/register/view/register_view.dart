import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  Widget build(context, RegisterController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Register Sobat",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff444444)),
                      ),
                      Transform.translate(
                        offset: const Offset(-20, -6),
                        child: const Divider(
                          thickness: 1.8,
                          indent: 100,
                          endIndent: 140,
                          color: Color(0xff444444),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  QTextField(
                      label: "Username",
                      validator: Validator.field,
                      onChanged: (value) {
                        controller.username = value;
                      },
                      preffixIcon: Icons.person_4),
                  const SizedBox(height: 10),
                  QTextField(
                      label: "Masukkan email",
                      validator: Validator.email,
                      onChanged: (value) {
                        controller.email = value;
                      },
                      preffixIcon: Icons.alternate_email_outlined),
                  const SizedBox(height: 10),
                  QTextField(
                      label: "Password",
                      validator: Validator.password,
                      onChanged: (value) {
                        controller.password = value;
                      },
                      preffixIcon: Icons.lock_outline),
                  const SizedBox(height: 20),
                  QButton(
                      onPressed: () {
                        controller.doRegister();
                      },
                      color: Colors.blue,
                      child: const Text("Register",
                          style: TextStyle(color: Colors.white))),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah punya akun? "),
                      InkWell(
                        onTap: () => Get.to(const LoginView()),
                        child: const Text("Login",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  State<RegisterView> createState() => RegisterController();
}
