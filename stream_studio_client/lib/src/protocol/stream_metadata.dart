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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class StreamMetadata
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      isLive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isLive']),
      viewerCount: jsonSerialization['viewerCount'] as int,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String streamId;

  String title;

  String description;

  bool isLive;

  int viewerCount;

  DateTime? startedAt;

  /// Returns a shallow copy of this [StreamMetadata]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
