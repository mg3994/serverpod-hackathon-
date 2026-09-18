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
import 'package:stream_studio_server/src/generated/protocol.dart' as _icc0dkes;
import 'camera_control.dart' as _i5egoacg;
import 'overlay_config.dart' as _i5wjbxoj;
import 'scene_control.dart' as _ivqo3tx9;
import 'signaling_message.dart' as _idk4v8xb;
import 'stream_heartbeat.dart' as _iuw8y9dd;
import 'studio_chat_message.dart' as _i46ogjeh;

abstract class StudioMessage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StudioMessage._({
    required this.streamId,
    required this.type,
    this.cameraControl,
    this.sceneControl,
    this.overlayConfig,
    this.signalingMessage,
    this.heartbeat,
    this.chatMessage,
  });

  factory StudioMessage({
    required String streamId,
    required String type,
    _i5egoacg.CameraControl? cameraControl,
    _ivqo3tx9.SceneControl? sceneControl,
    _i5wjbxoj.OverlayConfig? overlayConfig,
    _idk4v8xb.SignalingMessage? signalingMessage,
    _iuw8y9dd.StreamHeartbeat? heartbeat,
    _i46ogjeh.StudioChatMessage? chatMessage,
  }) = _StudioMessageImpl;

  factory StudioMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudioMessage(
      streamId: jsonSerialization['streamId'] as String,
      type: jsonSerialization['type'] as String,
      cameraControl: jsonSerialization['cameraControl'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_i5egoacg.CameraControl>(
              jsonSerialization['cameraControl'],
            ),
      sceneControl: jsonSerialization['sceneControl'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_ivqo3tx9.SceneControl>(
              jsonSerialization['sceneControl'],
            ),
      overlayConfig: jsonSerialization['overlayConfig'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_i5wjbxoj.OverlayConfig>(
              jsonSerialization['overlayConfig'],
            ),
      signalingMessage: jsonSerialization['signalingMessage'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_idk4v8xb.SignalingMessage>(
              jsonSerialization['signalingMessage'],
            ),
      heartbeat: jsonSerialization['heartbeat'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_iuw8y9dd.StreamHeartbeat>(
              jsonSerialization['heartbeat'],
            ),
      chatMessage: jsonSerialization['chatMessage'] == null
          ? null
          : _icc0dkes.Protocol().deserialize<_i46ogjeh.StudioChatMessage>(
              jsonSerialization['chatMessage'],
            ),
    );
  }

  String streamId;

  String type;

  _i5egoacg.CameraControl? cameraControl;

  _ivqo3tx9.SceneControl? sceneControl;

  _i5wjbxoj.OverlayConfig? overlayConfig;

  _idk4v8xb.SignalingMessage? signalingMessage;

  _iuw8y9dd.StreamHeartbeat? heartbeat;

  _i46ogjeh.StudioChatMessage? chatMessage;

  /// Returns a shallow copy of this [StudioMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudioMessage copyWith({
    String? streamId,
    String? type,
    _i5egoacg.CameraControl? cameraControl,
    _ivqo3tx9.SceneControl? sceneControl,
    _i5wjbxoj.OverlayConfig? overlayConfig,
    _idk4v8xb.SignalingMessage? signalingMessage,
    _iuw8y9dd.StreamHeartbeat? heartbeat,
    _i46ogjeh.StudioChatMessage? chatMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudioMessage',
      'streamId': streamId,
      'type': type,
      if (cameraControl != null) 'cameraControl': cameraControl?.toJson(),
      if (sceneControl != null) 'sceneControl': sceneControl?.toJson(),
      if (overlayConfig != null) 'overlayConfig': overlayConfig?.toJson(),
      if (signalingMessage != null)
        'signalingMessage': signalingMessage?.toJson(),
      if (heartbeat != null) 'heartbeat': heartbeat?.toJson(),
      if (chatMessage != null) 'chatMessage': chatMessage?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudioMessage',
      'streamId': streamId,
      'type': type,
      if (cameraControl != null)
        'cameraControl': cameraControl?.toJsonForProtocol(),
      if (sceneControl != null)
        'sceneControl': sceneControl?.toJsonForProtocol(),
      if (overlayConfig != null)
        'overlayConfig': overlayConfig?.toJsonForProtocol(),
      if (signalingMessage != null)
        'signalingMessage': signalingMessage?.toJsonForProtocol(),
      if (heartbeat != null) 'heartbeat': heartbeat?.toJsonForProtocol(),
      if (chatMessage != null) 'chatMessage': chatMessage?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudioMessageImpl extends StudioMessage {
  _StudioMessageImpl({
    required String streamId,
    required String type,
    _i5egoacg.CameraControl? cameraControl,
    _ivqo3tx9.SceneControl? sceneControl,
    _i5wjbxoj.OverlayConfig? overlayConfig,
    _idk4v8xb.SignalingMessage? signalingMessage,
    _iuw8y9dd.StreamHeartbeat? heartbeat,
    _i46ogjeh.StudioChatMessage? chatMessage,
  }) : super._(
         streamId: streamId,
         type: type,
         cameraControl: cameraControl,
         sceneControl: sceneControl,
         overlayConfig: overlayConfig,
         signalingMessage: signalingMessage,
         heartbeat: heartbeat,
         chatMessage: chatMessage,
       );

  /// Returns a shallow copy of this [StudioMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudioMessage copyWith({
    String? streamId,
    String? type,
    Object? cameraControl = _Undefined,
    Object? sceneControl = _Undefined,
    Object? overlayConfig = _Undefined,
    Object? signalingMessage = _Undefined,
    Object? heartbeat = _Undefined,
    Object? chatMessage = _Undefined,
  }) {
    return StudioMessage(
      streamId: streamId ?? this.streamId,
      type: type ?? this.type,
      cameraControl: cameraControl is _i5egoacg.CameraControl?
          ? cameraControl
          : this.cameraControl?.copyWith(),
      sceneControl: sceneControl is _ivqo3tx9.SceneControl?
          ? sceneControl
          : this.sceneControl?.copyWith(),
      overlayConfig: overlayConfig is _i5wjbxoj.OverlayConfig?
          ? overlayConfig
          : this.overlayConfig?.copyWith(),
      signalingMessage: signalingMessage is _idk4v8xb.SignalingMessage?
          ? signalingMessage
          : this.signalingMessage?.copyWith(),
      heartbeat: heartbeat is _iuw8y9dd.StreamHeartbeat?
          ? heartbeat
          : this.heartbeat?.copyWith(),
      chatMessage: chatMessage is _i46ogjeh.StudioChatMessage?
          ? chatMessage
          : this.chatMessage?.copyWith(),
    );
  }
}
