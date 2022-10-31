import 'package:get/get.dart';
import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';

import '../../../core/database/objectbox.dart';

class AddStudentController extends GetxController {
  late ObjectBox _objectBox;
  RxList<Class> classes = RxList();
  RxBool isLoading = false.obs;
  RxInt addStudentStatus = 100.obs;

  AddStudentController() {
    _objectBox = ObjectBox();
    loadClasses();
  }

  loadClasses() async {
    showLoading();
    final result = await _objectBox.getClasses();
    hideLoading();

    classes = result.obs;
  }

  addStudent(Student? student, Class? classObject, String nameStudent) {
    showLoading();
    _objectBox.addStudent(student, classObject, nameStudent);
    hideLoading();
    addStudentStatus = STATUS_SUCCESS.obs;
  }

  addClass(String className) {
    _objectBox.addClass(className);
    loadClasses();
  }

  Class getClass(int? id) {
    if (id == null) return classes.first;
    return _objectBox.getClass(id);
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
