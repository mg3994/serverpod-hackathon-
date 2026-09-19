/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:stream_studio_client/src/protocol/overlay_preset.dart'
    as _ii7eikmo;
import 'package:stream_studio_client/src/protocol/rtmp_destination.dart'
    as _ik58i5cj;
import 'banner_config.dart' as _i6bp45ta;
import 'branding_config.dart' as _ip33n6wn;
import 'broadcast_control.dart' as _ixxztjiw;
import 'camera_control.dart' as _i5egoacg;
import 'featured_comment.dart' as _idf8todo;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'overlay_config.dart' as _i5wjbxoj;
import 'overlay_preset.dart' as _ii3kajpc;
import 'rtmp_destination.dart' as _ivp2jp3i;
import 'scene_control.dart' as _ivqo3tx9;
import 'signaling_message.dart' as _idk4v8xb;
import 'stream_heartbeat.dart' as _iuw8y9dd;
import 'stream_metadata.dart' as _ikwzexvi;
import 'studio_chat_message.dart' as _i46ogjeh;
import 'studio_message.dart' as _i3ax77il;
export 'banner_config.dart';
export 'branding_config.dart';
export 'broadcast_control.dart';
export 'camera_control.dart';
export 'featured_comment.dart';
export 'greetings/greeting.dart';
export 'overlay_config.dart';
export 'overlay_preset.dart';
export 'rtmp_destination.dart';
export 'scene_control.dart';
export 'signaling_message.dart';
export 'stream_heartbeat.dart';
export 'stream_metadata.dart';
export 'studio_chat_message.dart';
export 'studio_message.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6bp45ta.BannerConfig) {
      return _i6bp45ta.BannerConfig.fromJson(data) as T;
    }
    if (t == _ip33n6wn.BrandingConfig) {
      return _ip33n6wn.BrandingConfig.fromJson(data) as T;
    }
    if (t == _ixxztjiw.BroadcastControl) {
      return _ixxztjiw.BroadcastControl.fromJson(data) as T;
    }
    if (t == _i5egoacg.CameraControl) {
      return _i5egoacg.CameraControl.fromJson(data) as T;
    }
    if (t == _idf8todo.FeaturedComment) {
      return _idf8todo.FeaturedComment.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i5wjbxoj.OverlayConfig) {
      return _i5wjbxoj.OverlayConfig.fromJson(data) as T;
    }
    if (t == _ii3kajpc.OverlayPreset) {
      return _ii3kajpc.OverlayPreset.fromJson(data) as T;
    }
    if (t == _ivp2jp3i.RtmpDestination) {
      return _ivp2jp3i.RtmpDestination.fromJson(data) as T;
    }
    if (t == _ivqo3tx9.SceneControl) {
      return _ivqo3tx9.SceneControl.fromJson(data) as T;
    }
    if (t == _idk4v8xb.SignalingMessage) {
      return _idk4v8xb.SignalingMessage.fromJson(data) as T;
    }
    if (t == _iuw8y9dd.StreamHeartbeat) {
      return _iuw8y9dd.StreamHeartbeat.fromJson(data) as T;
    }
    if (t == _ikwzexvi.StreamMetadata) {
      return _ikwzexvi.StreamMetadata.fromJson(data) as T;
    }
    if (t == _i46ogjeh.StudioChatMessage) {
      return _i46ogjeh.StudioChatMessage.fromJson(data) as T;
    }
    if (t == _i3ax77il.StudioMessage) {
      return _i3ax77il.StudioMessage.fromJson(data) as T;
    }
    if (t == _isc.getType<_i6bp45ta.BannerConfig?>()) {
      return (data != null ? _i6bp45ta.BannerConfig.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ip33n6wn.BrandingConfig?>()) {
      return (data != null ? _ip33n6wn.BrandingConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ixxztjiw.BroadcastControl?>()) {
      return (data != null ? _ixxztjiw.BroadcastControl.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5egoacg.CameraControl?>()) {
      return (data != null ? _i5egoacg.CameraControl.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idf8todo.FeaturedComment?>()) {
      return (data != null ? _idf8todo.FeaturedComment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5wjbxoj.OverlayConfig?>()) {
      return (data != null ? _i5wjbxoj.OverlayConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ii3kajpc.OverlayPreset?>()) {
      return (data != null ? _ii3kajpc.OverlayPreset.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivp2jp3i.RtmpDestination?>()) {
      return (data != null ? _ivp2jp3i.RtmpDestination.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivqo3tx9.SceneControl?>()) {
      return (data != null ? _ivqo3tx9.SceneControl.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idk4v8xb.SignalingMessage?>()) {
      return (data != null ? _idk4v8xb.SignalingMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iuw8y9dd.StreamHeartbeat?>()) {
      return (data != null ? _iuw8y9dd.StreamHeartbeat.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikwzexvi.StreamMetadata?>()) {
      return (data != null ? _ikwzexvi.StreamMetadata.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i46ogjeh.StudioChatMessage?>()) {
      return (data != null ? _i46ogjeh.StudioChatMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3ax77il.StudioMessage?>()) {
      return (data != null ? _i3ax77il.StudioMessage.fromJson(data) : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ii7eikmo.OverlayPreset>) {
      return (data as List)
              .map((e) => deserialize<_ii7eikmo.OverlayPreset>(e))
              .toList()
          as T;
    }
    if (t == List<_ik58i5cj.RtmpDestination>) {
      return (data as List)
              .map((e) => deserialize<_ik58i5cj.RtmpDestination>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6bp45ta.BannerConfig => 'BannerConfig',
      _ip33n6wn.BrandingConfig => 'BrandingConfig',
      _ixxztjiw.BroadcastControl => 'BroadcastControl',
      _i5egoacg.CameraControl => 'CameraControl',
      _idf8todo.FeaturedComment => 'FeaturedComment',
      _izw8z7ou.Greeting => 'Greeting',
      _i5wjbxoj.OverlayConfig => 'OverlayConfig',
      _ii3kajpc.OverlayPreset => 'OverlayPreset',
      _ivp2jp3i.RtmpDestination => 'RtmpDestination',
      _ivqo3tx9.SceneControl => 'SceneControl',
      _idk4v8xb.SignalingMessage => 'SignalingMessage',
      _iuw8y9dd.StreamHeartbeat => 'StreamHeartbeat',
      _ikwzexvi.StreamMetadata => 'StreamMetadata',
      _i46ogjeh.StudioChatMessage => 'StudioChatMessage',
      _i3ax77il.StudioMessage => 'StudioMessage',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'stream_studio.',
        '',
      );
    }

    switch (data) {
      case _i6bp45ta.BannerConfig():
        return 'BannerConfig';
      case _ip33n6wn.BrandingConfig():
        return 'BrandingConfig';
      case _ixxztjiw.BroadcastControl():
        return 'BroadcastControl';
      case _i5egoacg.CameraControl():
        return 'CameraControl';
      case _idf8todo.FeaturedComment():
        return 'FeaturedComment';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i5wjbxoj.OverlayConfig():
        return 'OverlayConfig';
      case _ii3kajpc.OverlayPreset():
        return 'OverlayPreset';
      case _ivp2jp3i.RtmpDestination():
        return 'RtmpDestination';
      case _ivqo3tx9.SceneControl():
        return 'SceneControl';
      case _idk4v8xb.SignalingMessage():
        return 'SignalingMessage';
      case _iuw8y9dd.StreamHeartbeat():
        return 'StreamHeartbeat';
      case _ikwzexvi.StreamMetadata():
        return 'StreamMetadata';
      case _i46ogjeh.StudioChatMessage():
        return 'StudioChatMessage';
      case _i3ax77il.StudioMessage():
        return 'StudioMessage';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BannerConfig') {
      return deserialize<_i6bp45ta.BannerConfig>(data['data']);
    }
    if (dataClassName == 'BrandingConfig') {
      return deserialize<_ip33n6wn.BrandingConfig>(data['data']);
    }
    if (dataClassName == 'BroadcastControl') {
      return deserialize<_ixxztjiw.BroadcastControl>(data['data']);
    }
    if (dataClassName == 'CameraControl') {
      return deserialize<_i5egoacg.CameraControl>(data['data']);
    }
    if (dataClassName == 'FeaturedComment') {
      return deserialize<_idf8todo.FeaturedComment>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'OverlayConfig') {
      return deserialize<_i5wjbxoj.OverlayConfig>(data['data']);
    }
    if (dataClassName == 'OverlayPreset') {
      return deserialize<_ii3kajpc.OverlayPreset>(data['data']);
    }
    if (dataClassName == 'RtmpDestination') {
      return deserialize<_ivp2jp3i.RtmpDestination>(data['data']);
    }
    if (dataClassName == 'SceneControl') {
      return deserialize<_ivqo3tx9.SceneControl>(data['data']);
    }
    if (dataClassName == 'SignalingMessage') {
      return deserialize<_idk4v8xb.SignalingMessage>(data['data']);
    }
    if (dataClassName == 'StreamHeartbeat') {
      return deserialize<_iuw8y9dd.StreamHeartbeat>(data['data']);
    }
    if (dataClassName == 'StreamMetadata') {
      return deserialize<_ikwzexvi.StreamMetadata>(data['data']);
    }
    if (dataClassName == 'StudioChatMessage') {
      return deserialize<_i46ogjeh.StudioChatMessage>(data['data']);
    }
    if (dataClassName == 'StudioMessage') {
      return deserialize<_i3ax77il.StudioMessage>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  String getModuleName() => 'stream_studio';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
