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

abstract class BroadcastControl
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BroadcastControl._({
    required this.streamId,
    required this.command,
    this.destinationId,
  });

  factory BroadcastControl({
    required String streamId,
    required String command,
    int? destinationId,
  }) = _BroadcastControlImpl;

  factory BroadcastControl.fromJson(Map<String, dynamic> jsonSerialization) {
    return BroadcastControl(
      streamId: jsonSerialization['streamId'] as String,
      command: jsonSerialization['command'] as String,
      destinationId: jsonSerialization['destinationId'] as int?,
    );
  }

  String streamId;

  String command;

  int? destinationId;

  /// Returns a shallow copy of this [BroadcastControl]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BroadcastControl copyWith({
    String? streamId,
    String? command,
    int? destinationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BroadcastControl',
      'streamId': streamId,
      'command': command,
      if (destinationId != null) 'destinationId': destinationId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BroadcastControl',
      'streamId': streamId,
      'command': command,
      if (destinationId != null) 'destinationId': destinationId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BroadcastControlImpl extends BroadcastControl {
  _BroadcastControlImpl({
    required String streamId,
    required String command,
    int? destinationId,
  }) : super._(
         streamId: streamId,
         command: command,
         destinationId: destinationId,
       );

  /// Returns a shallow copy of this [BroadcastControl]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BroadcastControl copyWith({
    String? streamId,
    String? command,
    Object? destinationId = _Undefined,
  }) {
    return BroadcastControl(
      streamId: streamId ?? this.streamId,
      command: command ?? this.command,
      destinationId: destinationId is int? ? destinationId : this.destinationId,
    );
  }
}
