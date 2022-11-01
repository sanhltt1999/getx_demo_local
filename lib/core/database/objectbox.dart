import 'package:getx_demo/core/model/class.dart';
import 'package:getx_demo/core/model/student.dart';
import 'package:getx_demo/core/database/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const statusSuccess = 0;
const statusFail = -1;

class ObjectBox {
  late final Store store;
  late final Box<Student> studentBox;
  late final Box<Class> classBox;

  static final ObjectBox _singleton = ObjectBox._internal();
  factory ObjectBox() {
    return _singleton;
  }
  ObjectBox._internal();

  void openBoxes() {
    studentBox = Box<Student>(store);
    classBox = Box<Class>(store);

    if (Admin.isAvailable()) {}

    if (studentBox.isEmpty()) {
      _putDemoData();
    }
  }

  Future<void> create() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final databaseDirectory =
        p.join(documentsDirectory.path, "getx_demo_local");
    store = await openStore(directory: databaseDirectory);
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

  addStudent(Student? student, Class? classObject, String nameStudent) {
    if (nameStudent.isEmpty || classObject == null) {
      return statusFail;
    }
    if (student == null) {
      student = Student(nameStudent, DateTime.now());
    } else {
      student.name = nameStudent;
    }
    student.classRoom.target = classObject;
    studentBox.put(student);
  }

  Future<List<Class>> getClasses() {
    final qBuilderTasks = classBox.query();
    final result = qBuilderTasks
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return result.first;
  }

  addClass(String nameClass) {
    Class classObject = Class(nameClass);
    classBox.put(classObject);
  }

  removeStudent(int id) {
    studentBox.remove(id);
  }
}
