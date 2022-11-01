import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_student_controller.dart';

class NewClass extends StatelessWidget {
  NewClass({Key? key}) : super(key: key);
  final _classInputController = TextEditingController();
  final controller = Get.find<AddStudentController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('New Class'),
      heroTag: null,
      onPressed: () async {
        final dialog = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('New Class'),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Enter the class name'),
              controller: _classInputController,
            ),
            actions: [
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  controller.addClass(_classInputController.text);
                  Get.back();
                },
              ),
            ],
          ),
        );
        _classInputController.clear();
        return dialog;
      },
    );
  }
}
