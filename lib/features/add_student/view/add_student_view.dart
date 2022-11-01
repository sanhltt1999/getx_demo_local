import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/features/add_student/controller/add_student_controller.dart';
import 'package:getx_demo/features/add_student/view/new_class.dart';

class AddStudentView extends StatelessWidget {
  AddStudentView({super.key});

  final controller = Get.find<AddStudentController>();
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Student? currentStudent = Get.arguments;
    controller.init(Get.arguments);
    inputController.text = currentStudent?.name ?? "";

    return Scaffold(
        appBar: AppBar(
            title:
                Text(currentStudent == null ? "Add Student" : 'Edit Student')),
        floatingActionButton: NewClass(),
        body: Obx(
          () {
            if (controller.addStudentStatus.value == statusSuccess) {
              Get.back(result: 'success');
            }
            return controller.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      Padding(
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
                            value: controller.currentClass.value.id,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: const Divider(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items:
                                controller.classes.map(buildMenuItem).toList(),
                            onChanged: (int? value) {
                              controller.currentClass.value =
                                  controller.getClass(value);
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextButton(
                                child: const Text('Save'),
                                onPressed: () {
                                  controller.addStudent(
                                      currentStudent,
                                      controller.currentClass.value,
                                      inputController.text);
                                }),
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
