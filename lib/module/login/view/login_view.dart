import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';
import 'package:todo_app/module/login/widget/row_divider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  Widget build(context, LoginController controller) {
    controller.view = this;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "Login Sobat",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff444444)),
                    ),
                    Transform.translate(
                      offset: const Offset(-20, -6),
                      child: const Divider(
                        thickness: 1.8,
                        indent: 120,
                        endIndent: 150,
                        color: Color(0xff444444),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Belum punya akun? "),
                    InkWell(
                      onTap: () => Get.to(const RegisterView()),
                      child: const Text("Register",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                QButton(
                    onPressed: () {
                      controller.doLoginEmail();
                    },
                    color: Colors.blue,
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 30),
                const RowDivider(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    QButton(
                        onPressed: () {
                          controller.doLoginGoogle();
                        },
                        color: Colors.red,
                        child: const Text("Login by Google",
                            style: TextStyle(color: Colors.white))),
                    QButton(
                        onPressed: () {
                          controller.doLoginAnonymous();
                        },
                        color: Colors.grey,
                        child: const Text("Login by Guest",
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
