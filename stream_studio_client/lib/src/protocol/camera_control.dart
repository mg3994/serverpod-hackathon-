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

abstract class CameraControl
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CameraControl._({
    required this.streamId,
    required this.torchOn,
    required this.zoomLevel,
    required this.activeCameraIndex,
    this.isMuted,
  });

  factory CameraControl({
    required String streamId,
    required bool torchOn,
    required double zoomLevel,
    required int activeCameraIndex,
    bool? isMuted,
  }) = _CameraControlImpl;

  factory CameraControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return CameraControl(
      streamId: jsonSerialization['streamId'] as String,
      torchOn: _isc.BoolJsonExtension.fromJson(jsonSerialization['torchOn']),
      zoomLevel: (jsonSerialization['zoomLevel'] as num).toDouble(),
      activeCameraIndex: jsonSerialization['activeCameraIndex'] as int,
      isMuted: jsonSerialization['isMuted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isMuted']),
    );
  }

  String streamId;

  bool torchOn;

  double zoomLevel;

  int activeCameraIndex;

  bool? isMuted;

  /// Returns a shallow copy of this [CameraControl]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CameraControl copyWith({
    String? streamId,
    bool? torchOn,
    double? zoomLevel,
    int? activeCameraIndex,
    bool? isMuted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CameraControl',
      'streamId': streamId,
      'torchOn': torchOn,
      'zoomLevel': zoomLevel,
      'activeCameraIndex': activeCameraIndex,
      if (isMuted != null) 'isMuted': isMuted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CameraControl',
      'streamId': streamId,
      'torchOn': torchOn,
      'zoomLevel': zoomLevel,
      'activeCameraIndex': activeCameraIndex,
      if (isMuted != null) 'isMuted': isMuted,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CameraControlImpl extends CameraControl {
  _CameraControlImpl({
    required String streamId,
    required bool torchOn,
    required double zoomLevel,
    required int activeCameraIndex,
    bool? isMuted,
  }) : super._(
         streamId: streamId,
         torchOn: torchOn,
         zoomLevel: zoomLevel,
         activeCameraIndex: activeCameraIndex,
         isMuted: isMuted,
       );

  /// Returns a shallow copy of this [CameraControl]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CameraControl copyWith({
    String? streamId,
    bool? torchOn,
    double? zoomLevel,
    int? activeCameraIndex,
    Object? isMuted = _Undefined,
  }) {
    return CameraControl(
      streamId: streamId ?? this.streamId,
      torchOn: torchOn ?? this.torchOn,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      activeCameraIndex: activeCameraIndex ?? this.activeCameraIndex,
      isMuted: isMuted is bool? ? isMuted : this.isMuted,
    );
  }
}
