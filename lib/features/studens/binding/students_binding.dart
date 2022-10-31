import 'package:get/get.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/features/studens/controller/students_controller.dart';

class StudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentsController());
  }
}
