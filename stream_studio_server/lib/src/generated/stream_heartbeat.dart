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

abstract class StreamHeartbeat
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StreamHeartbeat._({
    required this.streamId,
    required this.deviceId,
    required this.deviceType,
    required this.fps,
    required this.resolution,
    this.audioLevel,
    required this.timestamp,
  });

  factory StreamHeartbeat({
    required String streamId,
    required String deviceId,
    required String deviceType,
    required double fps,
    required String resolution,
    double? audioLevel,
    required DateTime timestamp,
  }) = _StreamHeartbeatImpl;

  factory StreamHeartbeat.fromJson(Map<String, dynamic> jsonSerialization) {
    return StreamHeartbeat(
      streamId: jsonSerialization['streamId'] as String,
      deviceId: jsonSerialization['deviceId'] as String,
      deviceType: jsonSerialization['deviceType'] as String,
      fps: (jsonSerialization['fps'] as num).toDouble(),
      resolution: jsonSerialization['resolution'] as String,
      audioLevel: (jsonSerialization['audioLevel'] as num?)?.toDouble(),
      timestamp: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
    );
  }

  String streamId;

  String deviceId;

  String deviceType;

  double fps;

  String resolution;

  double? audioLevel;

  DateTime timestamp;

  /// Returns a shallow copy of this [StreamHeartbeat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StreamHeartbeat copyWith({
    String? streamId,
    String? deviceId,
    String? deviceType,
    double? fps,
    String? resolution,
    double? audioLevel,
    DateTime? timestamp,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StreamHeartbeat',
      'streamId': streamId,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'fps': fps,
      'resolution': resolution,
      if (audioLevel != null) 'audioLevel': audioLevel,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StreamHeartbeat',
      'streamId': streamId,
      'deviceId': deviceId,
      'deviceType': deviceType,
      'fps': fps,
      'resolution': resolution,
      if (audioLevel != null) 'audioLevel': audioLevel,
      'timestamp': timestamp.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreamHeartbeatImpl extends StreamHeartbeat {
  _StreamHeartbeatImpl({
    required String streamId,
    required String deviceId,
    required String deviceType,
    required double fps,
    required String resolution,
    double? audioLevel,
    required DateTime timestamp,
  }) : super._(
         streamId: streamId,
         deviceId: deviceId,
         deviceType: deviceType,
         fps: fps,
         resolution: resolution,
         audioLevel: audioLevel,
         timestamp: timestamp,
       );

  /// Returns a shallow copy of this [StreamHeartbeat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StreamHeartbeat copyWith({
    String? streamId,
    String? deviceId,
    String? deviceType,
    double? fps,
    String? resolution,
    Object? audioLevel = _Undefined,
    DateTime? timestamp,
  }) {
    return StreamHeartbeat(
      streamId: streamId ?? this.streamId,
      deviceId: deviceId ?? this.deviceId,
      deviceType: deviceType ?? this.deviceType,
      fps: fps ?? this.fps,
      resolution: resolution ?? this.resolution,
      audioLevel: audioLevel is double? ? audioLevel : this.audioLevel,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
