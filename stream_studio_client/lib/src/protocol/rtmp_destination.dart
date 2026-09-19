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

abstract class RtmpDestination
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      enabled: _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String streamId;

  String platformName;

  String url;

  String streamKey;

  bool enabled;

  /// Returns a shallow copy of this [RtmpDestination]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
