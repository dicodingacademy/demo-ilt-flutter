// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_drift_service.dart';

// ignore_for_file: type=lint
class $PlaceTableTable extends PlaceTable
    with TableInfo<$PlaceTableTable, PlaceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likeMeta = const VerificationMeta('like');
  @override
  late final GeneratedColumn<int> like = GeneratedColumn<int>(
    'like',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    address,
    like,
    image,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('like')) {
      context.handle(
        _likeMeta,
        like.isAcceptableOrUnknown(data['like']!, _likeMeta),
      );
    } else if (isInserting) {
      context.missing(_likeMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      address:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}address'],
          )!,
      like:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}like'],
          )!,
      image:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image'],
          )!,
    );
  }

  @override
  $PlaceTableTable createAlias(String alias) {
    return $PlaceTableTable(attachedDatabase, alias);
  }
}

class PlaceData extends DataClass implements Insertable<PlaceData> {
  final int id;
  final String name;
  final String description;
  final String address;
  final int like;
  final String image;
  const PlaceData({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.like,
    required this.image,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['address'] = Variable<String>(address);
    map['like'] = Variable<int>(like);
    map['image'] = Variable<String>(image);
    return map;
  }

  PlaceTableCompanion toCompanion(bool nullToAbsent) {
    return PlaceTableCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      address: Value(address),
      like: Value(like),
      image: Value(image),
    );
  }

  factory PlaceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      address: serializer.fromJson<String>(json['address']),
      like: serializer.fromJson<int>(json['like']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'address': serializer.toJson<String>(address),
      'like': serializer.toJson<int>(like),
      'image': serializer.toJson<String>(image),
    };
  }

  PlaceData copyWith({
    int? id,
    String? name,
    String? description,
    String? address,
    int? like,
    String? image,
  }) => PlaceData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    address: address ?? this.address,
    like: like ?? this.like,
    image: image ?? this.image,
  );
  PlaceData copyWithCompanion(PlaceTableCompanion data) {
    return PlaceData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      address: data.address.present ? data.address.value : this.address,
      like: data.like.present ? data.like.value : this.like,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('like: $like, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, address, like, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.address == this.address &&
          other.like == this.like &&
          other.image == this.image);
}

class PlaceTableCompanion extends UpdateCompanion<PlaceData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> address;
  final Value<int> like;
  final Value<String> image;
  const PlaceTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.address = const Value.absent(),
    this.like = const Value.absent(),
    this.image = const Value.absent(),
  });
  PlaceTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String address,
    required int like,
    required String image,
  }) : name = Value(name),
       description = Value(description),
       address = Value(address),
       like = Value(like),
       image = Value(image);
  static Insertable<PlaceData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? address,
    Expression<int>? like,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (like != null) 'like': like,
      if (image != null) 'image': image,
    });
  }

  PlaceTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? address,
    Value<int>? like,
    Value<String>? image,
  }) {
    return PlaceTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      like: like ?? this.like,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (like.present) {
      map['like'] = Variable<int>(like.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('like: $like, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlaceTableTable placeTable = $PlaceTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [placeTable];
}

typedef $$PlaceTableTableCreateCompanionBuilder =
    PlaceTableCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      required String address,
      required int like,
      required String image,
    });
typedef $$PlaceTableTableUpdateCompanionBuilder =
    PlaceTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> address,
      Value<int> like,
      Value<String> image,
    });

class $$PlaceTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaceTableTable> {
  $$PlaceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get like => $composableBuilder(
    column: $table.like,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaceTableTable> {
  $$PlaceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get like => $composableBuilder(
    column: $table.like,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaceTableTable> {
  $$PlaceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get like =>
      $composableBuilder(column: $table.like, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);
}

class $$PlaceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaceTableTable,
          PlaceData,
          $$PlaceTableTableFilterComposer,
          $$PlaceTableTableOrderingComposer,
          $$PlaceTableTableAnnotationComposer,
          $$PlaceTableTableCreateCompanionBuilder,
          $$PlaceTableTableUpdateCompanionBuilder,
          (
            PlaceData,
            BaseReferences<_$AppDatabase, $PlaceTableTable, PlaceData>,
          ),
          PlaceData,
          PrefetchHooks Function()
        > {
  $$PlaceTableTableTableManager(_$AppDatabase db, $PlaceTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlaceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PlaceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlaceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> like = const Value.absent(),
                Value<String> image = const Value.absent(),
              }) => PlaceTableCompanion(
                id: id,
                name: name,
                description: description,
                address: address,
                like: like,
                image: image,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String address,
                required int like,
                required String image,
              }) => PlaceTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                address: address,
                like: like,
                image: image,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaceTableTable,
      PlaceData,
      $$PlaceTableTableFilterComposer,
      $$PlaceTableTableOrderingComposer,
      $$PlaceTableTableAnnotationComposer,
      $$PlaceTableTableCreateCompanionBuilder,
      $$PlaceTableTableUpdateCompanionBuilder,
      (PlaceData, BaseReferences<_$AppDatabase, $PlaceTableTable, PlaceData>),
      PlaceData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlaceTableTableTableManager get placeTable =>
      $$PlaceTableTableTableManager(_db, _db.placeTable);
}
