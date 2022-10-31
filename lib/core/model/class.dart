import 'package:objectbox/objectbox.dart';

@Entity()
class Class {
  @Id()
  int id = 0;
  String code;

  Class(this.code);
}
