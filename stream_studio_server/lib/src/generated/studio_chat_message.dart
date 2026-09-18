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
    required this.timestamp,
    this.isDirectorCue,
  });

  factory StudioChatMessage({
    required String streamId,
    required String senderName,
    required String message,
    required DateTime timestamp,
    bool? isDirectorCue,
  }) = _StudioChatMessageImpl;

  factory StudioChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudioChatMessage(
      streamId: jsonSerialization['streamId'] as String,
      senderName: jsonSerialization['senderName'] as String,
      message: jsonSerialization['message'] as String,
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      isDirectorCue: jsonSerialization['isDirectorCue'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDirectorCue']),
    );
  }

  String streamId;

  String senderName;

  String message;

  DateTime timestamp;

  bool? isDirectorCue;

  /// Returns a shallow copy of this [StudioChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudioChatMessage copyWith({
    String? streamId,
    String? senderName,
    String? message,
    DateTime? timestamp,
    bool? isDirectorCue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudioChatMessage',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      'timestamp': timestamp.toJson(),
      if (isDirectorCue != null) 'isDirectorCue': isDirectorCue,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudioChatMessage',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      'timestamp': timestamp.toJson(),
      if (isDirectorCue != null) 'isDirectorCue': isDirectorCue,
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
    required DateTime timestamp,
    bool? isDirectorCue,
  }) : super._(
         streamId: streamId,
         senderName: senderName,
         message: message,
         timestamp: timestamp,
         isDirectorCue: isDirectorCue,
       );

  /// Returns a shallow copy of this [StudioChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudioChatMessage copyWith({
    String? streamId,
    String? senderName,
    String? message,
    DateTime? timestamp,
    Object? isDirectorCue = _Undefined,
  }) {
    return StudioChatMessage(
      streamId: streamId ?? this.streamId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isDirectorCue: isDirectorCue is bool?
          ? isDirectorCue
          : this.isDirectorCue,
    );
  }
}
