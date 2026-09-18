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

abstract class StreamMetadata
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StreamMetadata._({
    this.id,
    required this.streamId,
    required this.title,
    required this.description,
    required this.isLive,
    required this.viewerCount,
    this.startedAt,
  });

  factory StreamMetadata({
    int? id,
    required String streamId,
    required String title,
    required String description,
    required bool isLive,
    required int viewerCount,
    DateTime? startedAt,
  }) = _StreamMetadataImpl;

  factory StreamMetadata.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreamMetadata(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      isLive: _is.BoolJsonExtension.fromJson(jsonSerialization['isLive']),
      viewerCount: jsonSerialization['viewerCount'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
    );
  }

  static final t = StreamMetadataTable();

  static const db = StreamMetadataRepository._();

  @override
  int? id;

  String streamId;

  String title;

  String description;

  bool isLive;

  int viewerCount;

  DateTime? startedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StreamMetadata]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StreamMetadata copyWith({
    int? id,
    String? streamId,
    String? title,
    String? description,
    bool? isLive,
    int? viewerCount,
    DateTime? startedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreamMetadata',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'description': description,
      'isLive': isLive,
      'viewerCount': viewerCount,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreamMetadata',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'description': description,
      'isLive': isLive,
      'viewerCount': viewerCount,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
    };
  }

  static StreamMetadataInclude include() {
    return StreamMetadataInclude._();
  }

  static StreamMetadataIncludeList includeList({
    _is.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    StreamMetadataInclude? include,
  }) {
    return StreamMetadataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreamMetadataImpl extends StreamMetadata {
  _StreamMetadataImpl({
    int? id,
    required String streamId,
    required String title,
    required String description,
    required bool isLive,
    required int viewerCount,
    DateTime? startedAt,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         description: description,
         isLive: isLive,
         viewerCount: viewerCount,
         startedAt: startedAt,
       );

  /// Returns a shallow copy of this [StreamMetadata]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StreamMetadata copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? title,
    String? description,
    bool? isLive,
    int? viewerCount,
    Object? startedAt = _Undefined,
  }) {
    return StreamMetadata(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      description: description ?? this.description,
      isLive: isLive ?? this.isLive,
      viewerCount: viewerCount ?? this.viewerCount,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
    );
  }
}

class StreamMetadataUpdateTable extends _is.UpdateTable<StreamMetadataTable> {
  StreamMetadataUpdateTable(super.table);

  _is.ColumnValue<String, String> streamId(String value) => _is.ColumnValue(
    table.streamId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<bool, bool> isLive(bool value) => _is.ColumnValue(
    table.isLive,
    value,
  );

  _is.ColumnValue<int, int> viewerCount(int value) => _is.ColumnValue(
    table.viewerCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );
}

class StreamMetadataTable extends _is.Table<int?> {
  StreamMetadataTable({super.tableRelation})
    : super(tableName: 'stream_metadata') {
    updateTable = StreamMetadataUpdateTable(this);
    streamId = _is.ColumnString(
      'streamId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    isLive = _is.ColumnBool(
      'isLive',
      this,
    );
    viewerCount = _is.ColumnInt(
      'viewerCount',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
  }

  late final StreamMetadataUpdateTable updateTable;

  late final _is.ColumnString streamId;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnBool isLive;

  late final _is.ColumnInt viewerCount;

  late final _is.ColumnDateTime startedAt;

  @override
  List<_is.Column> get columns => [
    id,
    streamId,
    title,
    description,
    isLive,
    viewerCount,
    startedAt,
  ];
}

class StreamMetadataInclude extends _is.IncludeObject {
  StreamMetadataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => StreamMetadata.t;
}

class StreamMetadataIncludeList extends _is.IncludeList {
  StreamMetadataIncludeList._({
    _is.WhereExpressionBuilder<StreamMetadataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StreamMetadata.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StreamMetadata.t;
}

class StreamMetadataRepository {
  const StreamMetadataRepository._();

  /// Returns a list of [StreamMetadata]s matching the given query parameters.
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
  Future<List<StreamMetadata>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StreamMetadata] matching the given query parameters.
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
  Future<StreamMetadata?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? offset,
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StreamMetadata] by its [id] or null if no such row exists.
  Future<StreamMetadata?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StreamMetadata>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StreamMetadata]s in the list and returns the inserted rows.
  ///
  /// The returned [StreamMetadata]s will have their `id` fields set.
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
  Future<List<StreamMetadata>> insert(
    _is.DatabaseSession session,
    List<StreamMetadata> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StreamMetadata>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StreamMetadata] and returns the inserted row.
  ///
  /// The returned [StreamMetadata] will have its `id` field set.
  Future<StreamMetadata> insertRow(
    _is.DatabaseSession session,
    StreamMetadata row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StreamMetadata>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StreamMetadata]s in the list and returns the resulting rows.
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
  /// The returned [StreamMetadata]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreamMetadata>> upsert(
    _is.DatabaseSession session,
    List<StreamMetadata> rows, {
    required _is.ColumnSelections<StreamMetadataTable> conflictColumns,
    _is.ColumnSelections<StreamMetadataTable>? updateColumns,
    _is.WhereExpressionBuilder<StreamMetadataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StreamMetadata>(
      rows,
      conflictColumns: conflictColumns(StreamMetadata.t),
      updateColumns: updateColumns?.call(StreamMetadata.t),
      updateWhere: updateWhere?.call(StreamMetadata.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StreamMetadata] and returns the resulting row.
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
  /// The returned [StreamMetadata] will have its `id` field set.
  Future<StreamMetadata?> upsertRow(
    _is.DatabaseSession session,
    StreamMetadata row, {
    required _is.ColumnSelections<StreamMetadataTable> conflictColumns,
    _is.ColumnSelections<StreamMetadataTable>? updateColumns,
    _is.WhereExpressionBuilder<StreamMetadataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StreamMetadata>(
      row,
      conflictColumns: conflictColumns(StreamMetadata.t),
      updateColumns: updateColumns?.call(StreamMetadata.t),
      updateWhere: updateWhere?.call(StreamMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates all [StreamMetadata]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreamMetadata>> update(
    _is.DatabaseSession session,
    List<StreamMetadata> rows, {
    _is.ColumnSelections<StreamMetadataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StreamMetadata>(
      rows,
      columns: columns?.call(StreamMetadata.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StreamMetadata]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StreamMetadata> updateRow(
    _is.DatabaseSession session,
    StreamMetadata row, {
    _is.ColumnSelections<StreamMetadataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StreamMetadata>(
      row,
      columns: columns?.call(StreamMetadata.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StreamMetadata] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StreamMetadata?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StreamMetadataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StreamMetadata>(
      id,
      columnValues: columnValues(StreamMetadata.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StreamMetadata]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StreamMetadata>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StreamMetadataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StreamMetadataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StreamMetadata>(
      columnValues: columnValues(StreamMetadata.t.updateTable),
      where: where(StreamMetadata.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StreamMetadata]s in the list and returns the deleted rows.
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
  Future<List<StreamMetadata>> delete(
    _is.DatabaseSession session,
    List<StreamMetadata> rows, {
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StreamMetadata>(
      rows,
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StreamMetadata].
  Future<StreamMetadata> deleteRow(
    _is.DatabaseSession session,
    StreamMetadata row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StreamMetadata>(
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
  Future<List<StreamMetadata>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StreamMetadataTable> where,
    _is.OrderByBuilder<StreamMetadataTable>? orderBy,
    _is.OrderByListBuilder<StreamMetadataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StreamMetadata>(
      where: where(StreamMetadata.t),
      orderBy: orderBy?.call(StreamMetadata.t),
      orderByList: orderByList?.call(StreamMetadata.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StreamMetadataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StreamMetadata>(
      where: where?.call(StreamMetadata.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StreamMetadata] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StreamMetadataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StreamMetadata>(
      where: where(StreamMetadata.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
