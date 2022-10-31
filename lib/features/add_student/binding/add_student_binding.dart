import 'package:get/get.dart';
import 'package:getx_demo/features/add_student/controller/add_student_controller.dart';

class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddStudentController());
  }
}
