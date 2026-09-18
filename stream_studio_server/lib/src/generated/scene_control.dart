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

abstract class SceneControl
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SceneControl._({
    required this.streamId,
    required this.activeScene,
    this.transitionType,
  });

  factory SceneControl({
    required String streamId,
    required String activeScene,
    String? transitionType,
  }) = _SceneControlImpl;

  factory SceneControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return SceneControl(
      streamId: jsonSerialization['streamId'] as String,
      activeScene: jsonSerialization['activeScene'] as String,
      transitionType: jsonSerialization['transitionType'] as String?,
    );
  }

  String streamId;

  String activeScene;

  String? transitionType;

  /// Returns a shallow copy of this [SceneControl]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SceneControl copyWith({
    String? streamId,
    String? activeScene,
    String? transitionType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SceneControl',
      'streamId': streamId,
      'activeScene': activeScene,
      if (transitionType != null) 'transitionType': transitionType,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SceneControl',
      'streamId': streamId,
      'activeScene': activeScene,
      if (transitionType != null) 'transitionType': transitionType,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SceneControlImpl extends SceneControl {
  _SceneControlImpl({
    required String streamId,
    required String activeScene,
    String? transitionType,
  }) : super._(
         streamId: streamId,
         activeScene: activeScene,
         transitionType: transitionType,
       );

  /// Returns a shallow copy of this [SceneControl]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SceneControl copyWith({
    String? streamId,
    String? activeScene,
    Object? transitionType = _Undefined,
  }) {
    return SceneControl(
      streamId: streamId ?? this.streamId,
      activeScene: activeScene ?? this.activeScene,
      transitionType: transitionType is String?
          ? transitionType
          : this.transitionType,
    );
  }
}
