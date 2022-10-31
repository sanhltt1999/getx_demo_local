import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/core/database/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const STATUS_SUCCESS = 0;
const STATUS_FAIL = -1;

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
    Class class2Object = Class("18TCLC_DT2");

    classBox.putMany([classObject, class2Object]);

    Student student = Student("Sanh", DateTime.now());
    student.classRoom.target = classObject;

    studentBox.put(student);
  }

  getClass(int id) {
    return classBox.get(id);
  }

  Future<List<Student>> getStudents() {
    final qBuilderTasks = studentBox.query();
    final result = qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return result.first;
  }

  Future<int> addStudent(
      Student? student, Class? classObject, String nameStudent) async {
    if (nameStudent.isEmpty || classObject == null) {
      return STATUS_FAIL;
    }
    if (student == null) {
      student = Student(nameStudent, DateTime.now());
    } else {
      student.name = nameStudent;
    }
    student.classRoom.target = classObject;
    studentBox.put(student);
    return STATUS_SUCCESS;
  }

  Future<List<Class>> getClasses() {
    final qBuilderTasks = classBox.query();
    final result = qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return result.first;
  }
}
