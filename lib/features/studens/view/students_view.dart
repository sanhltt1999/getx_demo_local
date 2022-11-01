import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/constants/routes.dart';
import 'package:getx_demo/features/studens/controller/students_controller.dart';

const keyStudent = 'student';

class StudentsView extends StatelessWidget {
  StudentsView({super.key});

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
            final result = await Get.toNamed(addStudentRoute);
            if (result == 'success') {
              controller.loadStudents();
            }
          },
          label: const Text("Add student")),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: ((context, index) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                controller.students[index].name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  controller.students[index].classRoom.target
                                          ?.code ??
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
                      TextButton(
                          child: const Text('Edit'),
                          onPressed: () async {
                            final result = await Get.toNamed(addStudentRoute,
                                arguments: controller.students[index]);
                            if (result == 'success') {
                              controller.loadStudents();
                            }
                          }),
                      TextButton(
                          child: const Text('Delete'),
                          onPressed: () async {
                            controller
                                .removeStudent(controller.students[index].id);
                          }),
                    ],
                  );
                }),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.students.length,
              );
      }),
    );
  }
}
