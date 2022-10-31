import 'package:getx_demo/core/model/class.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Student {
  @Id()
  int id = 0;
  String name;

  @Property(type: PropertyType.date)
  DateTime dateCreated;

  Student(this.name, this.dateCreated);

  final classRoom = ToOne<Class>();
}
