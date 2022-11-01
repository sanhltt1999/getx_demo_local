import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:getx_demo/constants/routes.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/features/add_student/binding/add_student_binding.dart';
import 'package:getx_demo/features/add_student/view/add_student_view.dart';

import 'features/studens/binding/students_binding.dart';
import 'features/studens/view/students_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBox().create();
  ObjectBox().openBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
          page: () => AddStudentView(),
          binding: AddStudentBinding(),
        )
      ],
      initialRoute: stutdentsRoute,
    );
  }
}
