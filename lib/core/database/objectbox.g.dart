// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../model/class.dart';
import '../model/student.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3524183436980628419),
      name: 'Class',
      lastPropertyId: const IdUid(2, 4475157850492076764),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1431773264493000259),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4475157850492076764),
            name: 'code',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 865460508038738765),
      name: 'Student',
      lastPropertyId: const IdUid(4, 3403803257263536951),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5577027482803223550),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 204904200721614069),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6207083115722882113),
            name: 'dateCreated',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3403803257263536951),
            name: 'classRoomId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 4698567995489262705),
            relationTarget: 'Class')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 865460508038738765),
      lastIndexId: const IdUid(1, 4698567995489262705),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Class: EntityDefinition<Class>(
        model: _entities[0],
        toOneRelations: (Class object) => [],
        toManyRelations: (Class object) => {},
        getId: (Class object) => object.id,
        setId: (Class object, int id) {
          object.id = id;
        },
        objectToFB: (Class object, fb.Builder fbb) {
          final codeOffset = fbb.writeString(object.code);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, codeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Class(const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    Student: EntityDefinition<Student>(
        model: _entities[1],
        toOneRelations: (Student object) => [object.classRoom],
        toManyRelations: (Student object) => {},
        getId: (Student object) => object.id,
        setId: (Student object, int id) {
          object.id = id;
        },
        objectToFB: (Student object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addInt64(2, object.dateCreated.millisecondsSinceEpoch);
          fbb.addInt64(3, object.classRoom.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Student(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.classRoom.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.classRoom.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Class] entity fields to define ObjectBox queries.
class Class_ {
  /// see [Class.id]
  static final id = QueryIntegerProperty<Class>(_entities[0].properties[0]);

  /// see [Class.code]
  static final code = QueryStringProperty<Class>(_entities[0].properties[1]);
}

/// [Student] entity fields to define ObjectBox queries.
class Student_ {
  /// see [Student.id]
  static final id = QueryIntegerProperty<Student>(_entities[1].properties[0]);

  /// see [Student.name]
  static final name = QueryStringProperty<Student>(_entities[1].properties[1]);

  /// see [Student.dateCreated]
  static final dateCreated =
      QueryIntegerProperty<Student>(_entities[1].properties[2]);

  /// see [Student.classRoom]
  static final classRoom =
      QueryRelationToOne<Student, Class>(_entities[1].properties[3]);
}
