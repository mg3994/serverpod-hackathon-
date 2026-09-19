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
import 'banner_config.dart' as _i6bp45ta;
import 'branding_config.dart' as _ip33n6wn;
import 'broadcast_control.dart' as _ixxztjiw;
import 'camera_control.dart' as _i5egoacg;
import 'featured_comment.dart' as _idf8todo;
import 'overlay_config.dart' as _i5wjbxoj;
import 'scene_control.dart' as _ivqo3tx9;
import 'signaling_message.dart' as _idk4v8xb;
import 'stream_heartbeat.dart' as _iuw8y9dd;
import 'studio_chat_message.dart' as _i46ogjeh;

abstract class StudioMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StudioMessage._({
    required this.streamId,
    required this.type,
    this.cameraControl,
    this.sceneControl,
    this.overlayConfig,
    this.signalingMessage,
    this.heartbeat,
    this.chatMessage,
    this.broadcastControl,
    this.featuredComment,
    this.brandingConfig,
    this.bannerConfig,
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
    _ixxztjiw.BroadcastControl? broadcastControl,
    _idf8todo.FeaturedComment? featuredComment,
    _ip33n6wn.BrandingConfig? brandingConfig,
    _i6bp45ta.BannerConfig? bannerConfig,
  }) = _StudioMessageImpl;

  factory StudioMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudioMessage(
      streamId: jsonSerialization['streamId'] as String,
      type: jsonSerialization['type'] as String,
      cameraControl: jsonSerialization['cameraControl'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_i5egoacg.CameraControl>(
              jsonSerialization['cameraControl'],
            ),
      sceneControl: jsonSerialization['sceneControl'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_ivqo3tx9.SceneControl>(
              jsonSerialization['sceneControl'],
            ),
      overlayConfig: jsonSerialization['overlayConfig'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_i5wjbxoj.OverlayConfig>(
              jsonSerialization['overlayConfig'],
            ),
      signalingMessage: jsonSerialization['signalingMessage'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_idk4v8xb.SignalingMessage>(
              jsonSerialization['signalingMessage'],
            ),
      heartbeat: jsonSerialization['heartbeat'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_iuw8y9dd.StreamHeartbeat>(
              jsonSerialization['heartbeat'],
            ),
      chatMessage: jsonSerialization['chatMessage'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_i46ogjeh.StudioChatMessage>(
              jsonSerialization['chatMessage'],
            ),
      broadcastControl: jsonSerialization['broadcastControl'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_ixxztjiw.BroadcastControl>(
              jsonSerialization['broadcastControl'],
            ),
      featuredComment: jsonSerialization['featuredComment'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_idf8todo.FeaturedComment>(
              jsonSerialization['featuredComment'],
            ),
      brandingConfig: jsonSerialization['brandingConfig'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_ip33n6wn.BrandingConfig>(
              jsonSerialization['brandingConfig'],
            ),
      bannerConfig: jsonSerialization['bannerConfig'] == null
          ? null
          : _i62n2zk0.Protocol().deserialize<_i6bp45ta.BannerConfig>(
              jsonSerialization['bannerConfig'],
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

  _ixxztjiw.BroadcastControl? broadcastControl;

  _idf8todo.FeaturedComment? featuredComment;

  _ip33n6wn.BrandingConfig? brandingConfig;

  _i6bp45ta.BannerConfig? bannerConfig;

  /// Returns a shallow copy of this [StudioMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudioMessage copyWith({
    String? streamId,
    String? type,
    _i5egoacg.CameraControl? cameraControl,
    _ivqo3tx9.SceneControl? sceneControl,
    _i5wjbxoj.OverlayConfig? overlayConfig,
    _idk4v8xb.SignalingMessage? signalingMessage,
    _iuw8y9dd.StreamHeartbeat? heartbeat,
    _i46ogjeh.StudioChatMessage? chatMessage,
    _ixxztjiw.BroadcastControl? broadcastControl,
    _idf8todo.FeaturedComment? featuredComment,
    _ip33n6wn.BrandingConfig? brandingConfig,
    _i6bp45ta.BannerConfig? bannerConfig,
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
      if (broadcastControl != null)
        'broadcastControl': broadcastControl?.toJson(),
      if (featuredComment != null) 'featuredComment': featuredComment?.toJson(),
      if (brandingConfig != null) 'brandingConfig': brandingConfig?.toJson(),
      if (bannerConfig != null) 'bannerConfig': bannerConfig?.toJson(),
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
      if (broadcastControl != null)
        'broadcastControl': broadcastControl?.toJsonForProtocol(),
      if (featuredComment != null)
        'featuredComment': featuredComment?.toJsonForProtocol(),
      if (brandingConfig != null)
        'brandingConfig': brandingConfig?.toJsonForProtocol(),
      if (bannerConfig != null)
        'bannerConfig': bannerConfig?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
    _ixxztjiw.BroadcastControl? broadcastControl,
    _idf8todo.FeaturedComment? featuredComment,
    _ip33n6wn.BrandingConfig? brandingConfig,
    _i6bp45ta.BannerConfig? bannerConfig,
  }) : super._(
         streamId: streamId,
         type: type,
         cameraControl: cameraControl,
         sceneControl: sceneControl,
         overlayConfig: overlayConfig,
         signalingMessage: signalingMessage,
         heartbeat: heartbeat,
         chatMessage: chatMessage,
         broadcastControl: broadcastControl,
         featuredComment: featuredComment,
         brandingConfig: brandingConfig,
         bannerConfig: bannerConfig,
       );

  /// Returns a shallow copy of this [StudioMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
    Object? broadcastControl = _Undefined,
    Object? featuredComment = _Undefined,
    Object? brandingConfig = _Undefined,
    Object? bannerConfig = _Undefined,
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
      broadcastControl: broadcastControl is _ixxztjiw.BroadcastControl?
          ? broadcastControl
          : this.broadcastControl?.copyWith(),
      featuredComment: featuredComment is _idf8todo.FeaturedComment?
          ? featuredComment
          : this.featuredComment?.copyWith(),
      brandingConfig: brandingConfig is _ip33n6wn.BrandingConfig?
          ? brandingConfig
          : this.brandingConfig?.copyWith(),
      bannerConfig: bannerConfig is _i6bp45ta.BannerConfig?
          ? bannerConfig
          : this.bannerConfig?.copyWith(),
    );
  }
}
