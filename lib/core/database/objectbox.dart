import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/core/database/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  static late final Store store;
  static late final Box<Student> studentBox;
  static late final Box<Class> classBox;
  late final Admin _admin;

  static final ObjectBox _singleton = ObjectBox._internal();
  factory ObjectBox() {
    return _singleton;
  }
  ObjectBox._internal();

  ObjectBox._create() {
    studentBox = Box<Student>(store);
    classBox = Box<Class>(store);

    if (Admin.isAvailable()) {
      _admin = Admin(store);
    }

    if (studentBox.isEmpty()) {
      _putDemoData();
    }
  }

  Future<ObjectBox> create() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseDirectory =
        p.join(documentsDirectory.path, "getx_demo_local");
    store = await openStore(directory: databaseDirectory);
    return ObjectBox._create();
  }

  void _putDemoData() {
    Class classObject = Class("18TCLC_DT1");

    Student student = Student("Sanh", DateTime.now());
    student.classRoom.target = classObject;

    studentBox.put(student);
  }

  Future<List<Student>> getStudents() {
    final qBuilderTasks = studentBox.query();
    final result = qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return result.first;
  }

  Future<List<Class>> getClasses() {
    final qBuilderTasks = classBox.query();
    final result = qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return result.first;
  }
}
