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

abstract class RtmpDestination
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RtmpDestination._({
    this.id,
    required this.streamId,
    required this.platformName,
    required this.url,
    required this.streamKey,
    required this.enabled,
  });

  factory RtmpDestination({
    int? id,
    required String streamId,
    required String platformName,
    required String url,
    required String streamKey,
    required bool enabled,
  }) = _RtmpDestinationImpl;

  factory RtmpDestination.fromJson(Map<String, dynamic> jsonSerialization) {
    return RtmpDestination(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      platformName: jsonSerialization['platformName'] as String,
      url: jsonSerialization['url'] as String,
      streamKey: jsonSerialization['streamKey'] as String,
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  static final t = RtmpDestinationTable();

  static const db = RtmpDestinationRepository._();

  @override
  int? id;

  String streamId;

  String platformName;

  String url;

  String streamKey;

  bool enabled;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RtmpDestination]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RtmpDestination copyWith({
    int? id,
    String? streamId,
    String? platformName,
    String? url,
    String? streamKey,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RtmpDestination',
      if (id != null) 'id': id,
      'streamId': streamId,
      'platformName': platformName,
      'url': url,
      'streamKey': streamKey,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RtmpDestination',
      if (id != null) 'id': id,
      'streamId': streamId,
      'platformName': platformName,
      'url': url,
      'streamKey': streamKey,
      'enabled': enabled,
    };
  }

  static RtmpDestinationInclude include() {
    return RtmpDestinationInclude._();
  }

  static RtmpDestinationIncludeList includeList({
    _is.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    RtmpDestinationInclude? include,
  }) {
    return RtmpDestinationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RtmpDestinationImpl extends RtmpDestination {
  _RtmpDestinationImpl({
    int? id,
    required String streamId,
    required String platformName,
    required String url,
    required String streamKey,
    required bool enabled,
  }) : super._(
         id: id,
         streamId: streamId,
         platformName: platformName,
         url: url,
         streamKey: streamKey,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [RtmpDestination]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RtmpDestination copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? platformName,
    String? url,
    String? streamKey,
    bool? enabled,
  }) {
    return RtmpDestination(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      platformName: platformName ?? this.platformName,
      url: url ?? this.url,
      streamKey: streamKey ?? this.streamKey,
      enabled: enabled ?? this.enabled,
    );
  }
}

class RtmpDestinationUpdateTable extends _is.UpdateTable<RtmpDestinationTable> {
  RtmpDestinationUpdateTable(super.table);

  _is.ColumnValue<String, String> streamId(String value) => _is.ColumnValue(
    table.streamId,
    value,
  );

  _is.ColumnValue<String, String> platformName(String value) => _is.ColumnValue(
    table.platformName,
    value,
  );

  _is.ColumnValue<String, String> url(String value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> streamKey(String value) => _is.ColumnValue(
    table.streamKey,
    value,
  );

  _is.ColumnValue<bool, bool> enabled(bool value) => _is.ColumnValue(
    table.enabled,
    value,
  );
}

class RtmpDestinationTable extends _is.Table<int?> {
  RtmpDestinationTable({super.tableRelation})
    : super(tableName: 'rtmp_destination') {
    updateTable = RtmpDestinationUpdateTable(this);
    streamId = _is.ColumnString(
      'streamId',
      this,
    );
    platformName = _is.ColumnString(
      'platformName',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    streamKey = _is.ColumnString(
      'streamKey',
      this,
    );
    enabled = _is.ColumnBool(
      'enabled',
      this,
    );
  }

  late final RtmpDestinationUpdateTable updateTable;

  late final _is.ColumnString streamId;

  late final _is.ColumnString platformName;

  late final _is.ColumnString url;

  late final _is.ColumnString streamKey;

  late final _is.ColumnBool enabled;

  @override
  List<_is.Column> get columns => [
    id,
    streamId,
    platformName,
    url,
    streamKey,
    enabled,
  ];
}

class RtmpDestinationInclude extends _is.IncludeObject {
  RtmpDestinationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RtmpDestination.t;
}

class RtmpDestinationIncludeList extends _is.IncludeList {
  RtmpDestinationIncludeList._({
    _is.WhereExpressionBuilder<RtmpDestinationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RtmpDestination.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RtmpDestination.t;
}

class RtmpDestinationRepository {
  const RtmpDestinationRepository._();

  /// Returns a list of [RtmpDestination]s matching the given query parameters.
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
  Future<List<RtmpDestination>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RtmpDestination] matching the given query parameters.
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
  Future<RtmpDestination?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? offset,
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RtmpDestination] by its [id] or null if no such row exists.
  Future<RtmpDestination?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RtmpDestination>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RtmpDestination]s in the list and returns the inserted rows.
  ///
  /// The returned [RtmpDestination]s will have their `id` fields set.
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
  Future<List<RtmpDestination>> insert(
    _is.DatabaseSession session,
    List<RtmpDestination> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RtmpDestination>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RtmpDestination] and returns the inserted row.
  ///
  /// The returned [RtmpDestination] will have its `id` field set.
  Future<RtmpDestination> insertRow(
    _is.DatabaseSession session,
    RtmpDestination row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RtmpDestination>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RtmpDestination]s in the list and returns the resulting rows.
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
  /// The returned [RtmpDestination]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RtmpDestination>> upsert(
    _is.DatabaseSession session,
    List<RtmpDestination> rows, {
    required _is.ColumnSelections<RtmpDestinationTable> conflictColumns,
    _is.ColumnSelections<RtmpDestinationTable>? updateColumns,
    _is.WhereExpressionBuilder<RtmpDestinationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RtmpDestination>(
      rows,
      conflictColumns: conflictColumns(RtmpDestination.t),
      updateColumns: updateColumns?.call(RtmpDestination.t),
      updateWhere: updateWhere?.call(RtmpDestination.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RtmpDestination] and returns the resulting row.
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
  /// The returned [RtmpDestination] will have its `id` field set.
  Future<RtmpDestination?> upsertRow(
    _is.DatabaseSession session,
    RtmpDestination row, {
    required _is.ColumnSelections<RtmpDestinationTable> conflictColumns,
    _is.ColumnSelections<RtmpDestinationTable>? updateColumns,
    _is.WhereExpressionBuilder<RtmpDestinationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RtmpDestination>(
      row,
      conflictColumns: conflictColumns(RtmpDestination.t),
      updateColumns: updateColumns?.call(RtmpDestination.t),
      updateWhere: updateWhere?.call(RtmpDestination.t),
      transaction: transaction,
    );
  }

  /// Updates all [RtmpDestination]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RtmpDestination>> update(
    _is.DatabaseSession session,
    List<RtmpDestination> rows, {
    _is.ColumnSelections<RtmpDestinationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RtmpDestination>(
      rows,
      columns: columns?.call(RtmpDestination.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RtmpDestination]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RtmpDestination> updateRow(
    _is.DatabaseSession session,
    RtmpDestination row, {
    _is.ColumnSelections<RtmpDestinationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RtmpDestination>(
      row,
      columns: columns?.call(RtmpDestination.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RtmpDestination] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RtmpDestination?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RtmpDestinationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RtmpDestination>(
      id,
      columnValues: columnValues(RtmpDestination.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RtmpDestination]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RtmpDestination>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RtmpDestinationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RtmpDestinationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RtmpDestination>(
      columnValues: columnValues(RtmpDestination.t.updateTable),
      where: where(RtmpDestination.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RtmpDestination]s in the list and returns the deleted rows.
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
  Future<List<RtmpDestination>> delete(
    _is.DatabaseSession session,
    List<RtmpDestination> rows, {
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RtmpDestination>(
      rows,
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RtmpDestination].
  Future<RtmpDestination> deleteRow(
    _is.DatabaseSession session,
    RtmpDestination row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RtmpDestination>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RtmpDestination>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RtmpDestinationTable> where,
    _is.OrderByBuilder<RtmpDestinationTable>? orderBy,
    _is.OrderByListBuilder<RtmpDestinationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RtmpDestination>(
      where: where(RtmpDestination.t),
      orderBy: orderBy?.call(RtmpDestination.t),
      orderByList: orderByList?.call(RtmpDestination.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RtmpDestinationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RtmpDestination>(
      where: where?.call(RtmpDestination.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RtmpDestination] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RtmpDestinationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RtmpDestination>(
      where: where(RtmpDestination.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
