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

abstract class StudioChatMessage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StudioChatMessage._({
    required this.streamId,
    required this.senderName,
    required this.message,
    this.platform,
    this.avatarUrl,
    required this.timestamp,
    this.isDirectorCue,
    this.isPrivate,
    this.targetDeviceId,
  });

  factory StudioChatMessage({
    required String streamId,
    required String senderName,
    required String message,
    String? platform,
    String? avatarUrl,
    required DateTime timestamp,
    bool? isDirectorCue,
    bool? isPrivate,
    String? targetDeviceId,
  }) = _StudioChatMessageImpl;

  factory StudioChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudioChatMessage(
      streamId: jsonSerialization['streamId'] as String,
      senderName: jsonSerialization['senderName'] as String,
      message: jsonSerialization['message'] as String,
      platform: jsonSerialization['platform'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      isDirectorCue: jsonSerialization['isDirectorCue'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDirectorCue']),
      isPrivate: jsonSerialization['isPrivate'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPrivate']),
      targetDeviceId: jsonSerialization['targetDeviceId'] as String?,
    );
  }

  String streamId;

  String senderName;

  String message;

  String? platform;

  String? avatarUrl;

  DateTime timestamp;

  bool? isDirectorCue;

  bool? isPrivate;

  String? targetDeviceId;

  /// Returns a shallow copy of this [StudioChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudioChatMessage copyWith({
    String? streamId,
    String? senderName,
    String? message,
    String? platform,
    String? avatarUrl,
    DateTime? timestamp,
    bool? isDirectorCue,
    bool? isPrivate,
    String? targetDeviceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudioChatMessage',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      if (platform != null) 'platform': platform,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'timestamp': timestamp.toJson(),
      if (isDirectorCue != null) 'isDirectorCue': isDirectorCue,
      if (isPrivate != null) 'isPrivate': isPrivate,
      if (targetDeviceId != null) 'targetDeviceId': targetDeviceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudioChatMessage',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      if (platform != null) 'platform': platform,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'timestamp': timestamp.toJson(),
      if (isDirectorCue != null) 'isDirectorCue': isDirectorCue,
      if (isPrivate != null) 'isPrivate': isPrivate,
      if (targetDeviceId != null) 'targetDeviceId': targetDeviceId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudioChatMessageImpl extends StudioChatMessage {
  _StudioChatMessageImpl({
    required String streamId,
    required String senderName,
    required String message,
    String? platform,
    String? avatarUrl,
    required DateTime timestamp,
    bool? isDirectorCue,
    bool? isPrivate,
    String? targetDeviceId,
  }) : super._(
         streamId: streamId,
         senderName: senderName,
         message: message,
         platform: platform,
         avatarUrl: avatarUrl,
         timestamp: timestamp,
         isDirectorCue: isDirectorCue,
         isPrivate: isPrivate,
         targetDeviceId: targetDeviceId,
       );

  /// Returns a shallow copy of this [StudioChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudioChatMessage copyWith({
    String? streamId,
    String? senderName,
    String? message,
    Object? platform = _Undefined,
    Object? avatarUrl = _Undefined,
    DateTime? timestamp,
    Object? isDirectorCue = _Undefined,
    Object? isPrivate = _Undefined,
    Object? targetDeviceId = _Undefined,
  }) {
    return StudioChatMessage(
      streamId: streamId ?? this.streamId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      platform: platform is String? ? platform : this.platform,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      timestamp: timestamp ?? this.timestamp,
      isDirectorCue: isDirectorCue is bool?
          ? isDirectorCue
          : this.isDirectorCue,
      isPrivate: isPrivate is bool? ? isPrivate : this.isPrivate,
      targetDeviceId: targetDeviceId is String?
          ? targetDeviceId
          : this.targetDeviceId,
    );
  }
}
