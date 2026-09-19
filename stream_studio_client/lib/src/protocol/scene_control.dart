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
import 'package:stream_studio_client/src/protocol/protocol.dart' as _i62n2zk0;

abstract class SceneControl
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SceneControl._({
    required this.streamId,
    this.targetDeviceId,
    required this.activeScene,
    required this.layout,
    required this.stageDeviceIds,
    this.programDeviceId,
    this.transitionType,
  });

  factory SceneControl({
    required String streamId,
    String? targetDeviceId,
    required String activeScene,
    required String layout,
    required List<String> stageDeviceIds,
    String? programDeviceId,
    String? transitionType,
  }) = _SceneControlImpl;

  factory SceneControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return SceneControl(
      streamId: jsonSerialization['streamId'] as String,
      targetDeviceId: jsonSerialization['targetDeviceId'] as String?,
      activeScene: jsonSerialization['activeScene'] as String,
      layout: jsonSerialization['layout'] as String,
      stageDeviceIds: _i62n2zk0.Protocol().deserialize<List<String>>(
        jsonSerialization['stageDeviceIds'],
      ),
      programDeviceId: jsonSerialization['programDeviceId'] as String?,
      transitionType: jsonSerialization['transitionType'] as String?,
    );
  }

  String streamId;

  String? targetDeviceId;

  String activeScene;

  String layout;

  List<String> stageDeviceIds;

  String? programDeviceId;

  String? transitionType;

  /// Returns a shallow copy of this [SceneControl]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SceneControl copyWith({
    String? streamId,
    String? targetDeviceId,
    String? activeScene,
    String? layout,
    List<String>? stageDeviceIds,
    String? programDeviceId,
    String? transitionType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SceneControl',
      'streamId': streamId,
      if (targetDeviceId != null) 'targetDeviceId': targetDeviceId,
      'activeScene': activeScene,
      'layout': layout,
      'stageDeviceIds': stageDeviceIds.toJson(),
      if (programDeviceId != null) 'programDeviceId': programDeviceId,
      if (transitionType != null) 'transitionType': transitionType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SceneControl',
      'streamId': streamId,
      if (targetDeviceId != null) 'targetDeviceId': targetDeviceId,
      'activeScene': activeScene,
      'layout': layout,
      'stageDeviceIds': stageDeviceIds.toJson(),
      if (programDeviceId != null) 'programDeviceId': programDeviceId,
      if (transitionType != null) 'transitionType': transitionType,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SceneControlImpl extends SceneControl {
  _SceneControlImpl({
    required String streamId,
    String? targetDeviceId,
    required String activeScene,
    required String layout,
    required List<String> stageDeviceIds,
    String? programDeviceId,
    String? transitionType,
  }) : super._(
         streamId: streamId,
         targetDeviceId: targetDeviceId,
         activeScene: activeScene,
         layout: layout,
         stageDeviceIds: stageDeviceIds,
         programDeviceId: programDeviceId,
         transitionType: transitionType,
       );

  /// Returns a shallow copy of this [SceneControl]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SceneControl copyWith({
    String? streamId,
    Object? targetDeviceId = _Undefined,
    String? activeScene,
    String? layout,
    List<String>? stageDeviceIds,
    Object? programDeviceId = _Undefined,
    Object? transitionType = _Undefined,
  }) {
    return SceneControl(
      streamId: streamId ?? this.streamId,
      targetDeviceId: targetDeviceId is String?
          ? targetDeviceId
          : this.targetDeviceId,
      activeScene: activeScene ?? this.activeScene,
      layout: layout ?? this.layout,
      stageDeviceIds:
          stageDeviceIds ?? this.stageDeviceIds.map((e0) => e0).toList(),
      programDeviceId: programDeviceId is String?
          ? programDeviceId
          : this.programDeviceId,
      transitionType: transitionType is String?
          ? transitionType
          : this.transitionType,
    );
  }
}
