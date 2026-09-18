/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class OverlayPreset
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OverlayPreset._({
    this.id,
    required this.streamId,
    required this.title,
    required this.subtitle,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
  });

  factory OverlayPreset({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) = _OverlayPresetImpl;

  factory OverlayPreset.fromJson(Map<String, dynamic> jsonSerialization) {
    return OverlayPreset(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      position: jsonSerialization['position'] as String,
      backgroundColor: jsonSerialization['backgroundColor'] as String,
      textColor: jsonSerialization['textColor'] as String,
    );
  }

  static final t = OverlayPresetTable();

  static const db = OverlayPresetRepository._();

  @override
  int? id;

  String streamId;

  String title;

  String subtitle;

  String position;

  String backgroundColor;

  String textColor;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OverlayPreset copyWith({
    int? id,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  static OverlayPresetInclude include() {
    return OverlayPresetInclude._();
  }

  static OverlayPresetIncludeList includeList({
    _is.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    OverlayPresetInclude? include,
  }) {
    return OverlayPresetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OverlayPresetImpl extends OverlayPreset {
  _OverlayPresetImpl({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         subtitle: subtitle,
         position: position,
         backgroundColor: backgroundColor,
         textColor: textColor,
       );

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OverlayPreset copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  }) {
    return OverlayPreset(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      position: position ?? this.position,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}

class OverlayPresetUpdateTable extends _is.UpdateTable<OverlayPresetTable> {
  OverlayPresetUpdateTable(super.table);

  _is.ColumnValue<String, String> streamId(String value) =>
      _is.ColumnValue(table.streamId, value);

  _is.ColumnValue<String, String> title(String value) =>
      _is.ColumnValue(table.title, value);

  _is.ColumnValue<String, String> subtitle(String value) =>
      _is.ColumnValue(table.subtitle, value);

  _is.ColumnValue<String, String> position(String value) =>
      _is.ColumnValue(table.position, value);

  _is.ColumnValue<String, String> backgroundColor(String value) =>
      _is.ColumnValue(table.backgroundColor, value);

  _is.ColumnValue<String, String> textColor(String value) =>
      _is.ColumnValue(table.textColor, value);
}

class OverlayPresetTable extends _is.Table<int?> {
  OverlayPresetTable({super.tableRelation})
    : super(tableName: 'overlay_preset') {
    updateTable = OverlayPresetUpdateTable(this);
    streamId = _is.ColumnString('streamId', this);
    title = _is.ColumnString('title', this);
    subtitle = _is.ColumnString('subtitle', this);
    position = _is.ColumnString('position', this);
    backgroundColor = _is.ColumnString('backgroundColor', this);
    textColor = _is.ColumnString('textColor', this);
  }

  late final OverlayPresetUpdateTable updateTable;

  late final _is.ColumnString streamId;

  late final _is.ColumnString title;

  late final _is.ColumnString subtitle;

  late final _is.ColumnString position;

  late final _is.ColumnString backgroundColor;

  late final _is.ColumnString textColor;

  @override
  List<_is.Column> get columns => [
    id,
    streamId,
    title,
    subtitle,
    position,
    backgroundColor,
    textColor,
  ];
}

class OverlayPresetInclude extends _is.IncludeObject {
  OverlayPresetInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OverlayPreset.t;
}

class OverlayPresetIncludeList extends _is.IncludeList {
  OverlayPresetIncludeList._({
    _is.WhereExpressionBuilder<OverlayPresetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OverlayPreset.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OverlayPreset.t;
}

class OverlayPresetRepository {
  const OverlayPresetRepository._();

  /// Returns a list of [OverlayPreset]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<OverlayPreset>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OverlayPreset] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<OverlayPreset?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? offset,
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OverlayPreset] by its [id] or null if no such row exists.
  Future<OverlayPreset?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OverlayPreset>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OverlayPreset]s in the list and returns the inserted rows.
  ///
  /// The returned [OverlayPreset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> insert(
    _is.DatabaseSession session,
    List<OverlayPreset> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OverlayPreset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OverlayPreset] and returns the inserted row.
  ///
  /// The returned [OverlayPreset] will have its `id` field set.
  Future<OverlayPreset> insertRow(
    _is.DatabaseSession session,
    OverlayPreset row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OverlayPreset>(row, transaction: transaction);
  }

  /// Upserts all [OverlayPreset]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [OverlayPreset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> upsert(
    _is.DatabaseSession session,
    List<OverlayPreset> rows, {
    required _is.ColumnSelections<OverlayPresetTable> conflictColumns,
    _is.ColumnSelections<OverlayPresetTable>? updateColumns,
    _is.WhereExpressionBuilder<OverlayPresetTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OverlayPreset>(
      rows,
      conflictColumns: conflictColumns(OverlayPreset.t),
      updateColumns: updateColumns?.call(OverlayPreset.t),
      updateWhere: updateWhere?.call(OverlayPreset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OverlayPreset] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [OverlayPreset] will have its `id` field set.
  Future<OverlayPreset?> upsertRow(
    _is.DatabaseSession session,
    OverlayPreset row, {
    required _is.ColumnSelections<OverlayPresetTable> conflictColumns,
    _is.ColumnSelections<OverlayPresetTable>? updateColumns,
    _is.WhereExpressionBuilder<OverlayPresetTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OverlayPreset>(
      row,
      conflictColumns: conflictColumns(OverlayPreset.t),
      updateColumns: updateColumns?.call(OverlayPreset.t),
      updateWhere: updateWhere?.call(OverlayPreset.t),
      transaction: transaction,
    );
  }

  /// Updates all [OverlayPreset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> update(
    _is.DatabaseSession session,
    List<OverlayPreset> rows, {
    _is.ColumnSelections<OverlayPresetTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OverlayPreset>(
      rows,
      columns: columns?.call(OverlayPreset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OverlayPreset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OverlayPreset> updateRow(
    _is.DatabaseSession session,
    OverlayPreset row, {
    _is.ColumnSelections<OverlayPresetTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OverlayPreset>(
      row,
      columns: columns?.call(OverlayPreset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OverlayPreset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OverlayPreset?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OverlayPresetUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OverlayPreset>(
      id,
      columnValues: columnValues(OverlayPreset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OverlayPreset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OverlayPresetUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OverlayPresetTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OverlayPreset>(
      columnValues: columnValues(OverlayPreset.t.updateTable),
      where: where(OverlayPreset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OverlayPreset]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> delete(
    _is.DatabaseSession session,
    List<OverlayPreset> rows, {
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OverlayPreset>(
      rows,
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OverlayPreset].
  Future<OverlayPreset> deleteRow(
    _is.DatabaseSession session,
    OverlayPreset row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OverlayPreset>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OverlayPreset>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OverlayPresetTable> where,
    _is.OrderByBuilder<OverlayPresetTable>? orderBy,
    _is.OrderByListBuilder<OverlayPresetTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OverlayPreset>(
      where: where(OverlayPreset.t),
      orderBy: orderBy?.call(OverlayPreset.t),
      orderByList: orderByList?.call(OverlayPreset.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OverlayPresetTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OverlayPreset>(
      where: where?.call(OverlayPreset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OverlayPreset] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OverlayPresetTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OverlayPreset>(
      where: where(OverlayPreset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
