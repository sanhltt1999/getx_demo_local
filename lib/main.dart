import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_demo/constants/routes.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/features/add_student/binding/add_student_binding.dart';
import 'package:getx_demo/features/add_student/view/add_student_view.dart';

import 'features/studens/binding/students_binding.dart';
import 'features/studens/view/students_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ObjectBox().create(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return GetMaterialApp(
              title: "Main",
              getPages: [
                GetPage(
                  name: stutdentsRoute,
                  page: () => StudentsView(),
                  binding: StudentsBinding(),
                ),
                GetPage(
                  name: addStudentRoute,
                  page: () => const AddStudentView(),
                  binding: AddStudentBinding(),
                )
              ],
              initialRoute: stutdentsRoute,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
