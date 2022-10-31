import 'package:get/get.dart';
import 'package:getx_demo/core/database/objectbox.dart';
import 'package:getx_demo/core/model/student.dart';

class StudentsController extends GetxController {
  late ObjectBox _objectBox;
  RxList<Student> students = RxList();
  RxBool isLoading = false.obs;

  StudentsController() {
    _objectBox = ObjectBox();
  }

  loadStudents() async {
    showLoading();
    final result = await _objectBox.getStudents();
    hideLoading();

    students = result.obs;
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
