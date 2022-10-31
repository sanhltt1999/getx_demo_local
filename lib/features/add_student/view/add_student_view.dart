import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/features/add_student/controller/add_student_controller.dart';
import 'package:getx_demo/features/studens/view/students_view.dart';

import '../../studens/controller/students_controller.dart';

class AddStudentView extends StatelessWidget {
  AddStudentView({Key? key}) : super(key: key);

  final controller = Get.find<AddStudentController>();
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Student? currentStudent = Get.arguments;
    print(currentStudent?.id.toString());
    return Scaffold(
        appBar: AppBar(
            title:
                Text(currentStudent == null ? "Add Student" : 'Edit Student')),
        body: Obx(
          () {
            return controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: inputController,
                          )),
                      Row(
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Tags: ",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ))),
                          DropdownButton<int>(
                              value: currentStudent?.id,
                              items: controller.classes
                                  .map(buildMenuItem)
                                  .toList(),
                              underline: Container(
                                height: 2,
                                color: Colors.blueAccent,
                              ),
                              onChanged: (value) => {}),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextButton(
                                child: const Text('Save'), onPressed: () {}),
                          ),
                        ],
                      ),
                    ]));
          },
        ));
  }

  DropdownMenuItem<int> buildMenuItem(Class item) => DropdownMenuItem(
      value: item.id,
      child: Text(
        item.code,
        style: const TextStyle(fontSize: 15.0, color: Colors.black),
      ));
}
