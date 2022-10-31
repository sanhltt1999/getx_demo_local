import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/features/add_student/controller/add_student_controller.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  final controller = Get.find<AddStudentController>();
  final inputController = TextEditingController();
  Student? currentStudent;
  Class? currentClass;

  @override
  void initState() {
    super.initState();
    currentStudent = Get.arguments;
    currentClass;
    if (currentStudent != null) {
      inputController.text = currentStudent?.name ?? '';
      currentClass = currentStudent?.classRoom.target;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(currentStudent?.id.toString());
    return Scaffold(
        appBar: AppBar(
            title:
                Text(currentStudent == null ? "Add Student" : 'Edit Student')),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, label: const Text("Add Class")),
        body: Obx(
          () {
            if (controller.addStudentStatus.value == STATUS_SUCCESS) {}

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
                            value: currentClass?.id,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            items:
                                controller.classes.map(buildMenuItem).toList(),
                            onChanged: (int? value) {
                              setState(() {
                                currentClass = controller.getBox(value);
                              });
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: TextButton(
                                child: const Text('Save'),
                                onPressed: () {
                                  Get.back(result: 'success');

                                  // controller.addStudent(currentStudent,
                                  //     currentClass, inputController.text);
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
