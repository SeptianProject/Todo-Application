import 'package:flutter/material.dart';
import 'package:todo_app/core.dart';

class TodoFormView extends StatefulWidget {
  const TodoFormView({super.key});

  Widget build(context, TodoFormController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("TodoForm"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              QTextField(
                  label: "Input Task",
                  validator: Validator.email,
                  onChanged: (value) {
                    controller.title = value;
                  },
                  preffixIcon: Icons.task_alt),
              const SizedBox(height: 20),
              QRadioButton(
                label: "Status",
                validator: Validator.radio,
                items: const [
                  {
                    "label": "Pending",
                    "value": "Pending",
                  },
                  {
                    "label": "Ongoing",
                    "value": "Ongoing",
                  },
                  {
                    "label": "Done",
                    "value": "Done",
                  }
                ],
                onChanged: (value) {
                  if (value == null) {
                    controller.status = "Pending";
                  }
                  controller.status = value;
                },
              ),
              const SizedBox(height: 20),
              QButton(
                  onPressed: () => controller.createTask(),
                  child: const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<TodoFormView> createState() => TodoFormController();
}
