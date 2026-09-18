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

abstract class SignalingMessage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SignalingMessage._({
    required this.senderId,
    required this.targetId,
    required this.type,
    this.sdp,
    this.candidate,
    this.sdpMid,
    this.sdpMLineIndex,
  });

  factory SignalingMessage({
    required String senderId,
    required String targetId,
    required String type,
    String? sdp,
    String? candidate,
    String? sdpMid,
    int? sdpMLineIndex,
  }) = _SignalingMessageImpl;

  factory SignalingMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SignalingMessage(
      senderId: jsonSerialization['senderId'] as String,
      targetId: jsonSerialization['targetId'] as String,
      type: jsonSerialization['type'] as String,
      sdp: jsonSerialization['sdp'] as String?,
      candidate: jsonSerialization['candidate'] as String?,
      sdpMid: jsonSerialization['sdpMid'] as String?,
      sdpMLineIndex: jsonSerialization['sdpMLineIndex'] as int?,
    );
  }

  String senderId;

  String targetId;

  String type;

  String? sdp;

  String? candidate;

  String? sdpMid;

  int? sdpMLineIndex;

  /// Returns a shallow copy of this [SignalingMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SignalingMessage copyWith({
    String? senderId,
    String? targetId,
    String? type,
    String? sdp,
    String? candidate,
    String? sdpMid,
    int? sdpMLineIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignalingMessage',
      'senderId': senderId,
      'targetId': targetId,
      'type': type,
      if (sdp != null) 'sdp': sdp,
      if (candidate != null) 'candidate': candidate,
      if (sdpMid != null) 'sdpMid': sdpMid,
      if (sdpMLineIndex != null) 'sdpMLineIndex': sdpMLineIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SignalingMessage',
      'senderId': senderId,
      'targetId': targetId,
      'type': type,
      if (sdp != null) 'sdp': sdp,
      if (candidate != null) 'candidate': candidate,
      if (sdpMid != null) 'sdpMid': sdpMid,
      if (sdpMLineIndex != null) 'sdpMLineIndex': sdpMLineIndex,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SignalingMessageImpl extends SignalingMessage {
  _SignalingMessageImpl({
    required String senderId,
    required String targetId,
    required String type,
    String? sdp,
    String? candidate,
    String? sdpMid,
    int? sdpMLineIndex,
  }) : super._(
         senderId: senderId,
         targetId: targetId,
         type: type,
         sdp: sdp,
         candidate: candidate,
         sdpMid: sdpMid,
         sdpMLineIndex: sdpMLineIndex,
       );

  /// Returns a shallow copy of this [SignalingMessage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SignalingMessage copyWith({
    String? senderId,
    String? targetId,
    String? type,
    Object? sdp = _Undefined,
    Object? candidate = _Undefined,
    Object? sdpMid = _Undefined,
    Object? sdpMLineIndex = _Undefined,
  }) {
    return SignalingMessage(
      senderId: senderId ?? this.senderId,
      targetId: targetId ?? this.targetId,
      type: type ?? this.type,
      sdp: sdp is String? ? sdp : this.sdp,
      candidate: candidate is String? ? candidate : this.candidate,
      sdpMid: sdpMid is String? ? sdpMid : this.sdpMid,
      sdpMLineIndex: sdpMLineIndex is int? ? sdpMLineIndex : this.sdpMLineIndex,
    );
  }
}
