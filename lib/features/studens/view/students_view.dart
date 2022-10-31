import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/constants/routes.dart';
import 'package:getx_demo/features/studens/controller/students_controller.dart';

const KEY_STUDENT = 'student';

class StudentsView extends StatefulWidget {
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  final controller = Get.find<StudentsController>();

  @override
  Widget build(BuildContext context) {
    controller.loadStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var data = await Get.to(addStudentRoute);
            print(data);
          },
          label: const Text("Add student")),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: ((context, index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black12))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    controller.students[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      controller.students[index].classRoom
                                              .target?.code ??
                                          "No class",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            child: const Text('Edit'),
                            onPressed: () {
                              Get.toNamed(addStudentRoute,
                                  arguments: controller.students[index]);
                            }),
                      ],
                    );
                  }),
                  separatorBuilder: (context, index) => const Divider(
                    height: 32,
                  ),
                  itemCount: controller.students.length,
                ),
              );
      }),
    );
  }
}
