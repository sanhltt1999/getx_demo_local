import 'package:get/get.dart';
import 'package:getx_demo/core/model/class.dart';

import '../../../core/database/objectbox.dart';

class AddStudentController extends GetxController {
  late ObjectBox _objectBox;
  RxList<Class> classes = RxList();
  RxBool isLoading = false.obs;

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

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }
}
