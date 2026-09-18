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

abstract class OverlayPreset
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OverlayPreset._({
    this.id,
    required this.streamId,
    required this.title,
    required this.subtitle,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
  });

  factory OverlayPreset({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) = _OverlayPresetImpl;

  factory OverlayPreset.fromJson(Map<String, dynamic> jsonSerialization) {
    return OverlayPreset(
      id: jsonSerialization['id'] as int?,
      streamId: jsonSerialization['streamId'] as String,
      title: jsonSerialization['title'] as String,
      subtitle: jsonSerialization['subtitle'] as String,
      position: jsonSerialization['position'] as String,
      backgroundColor: jsonSerialization['backgroundColor'] as String,
      textColor: jsonSerialization['textColor'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String streamId;

  String title;

  String subtitle;

  String position;

  String backgroundColor;

  String textColor;

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OverlayPreset copyWith({
    int? id,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OverlayPreset',
      if (id != null) 'id': id,
      'streamId': streamId,
      'title': title,
      'subtitle': subtitle,
      'position': position,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OverlayPresetImpl extends OverlayPreset {
  _OverlayPresetImpl({
    int? id,
    required String streamId,
    required String title,
    required String subtitle,
    required String position,
    required String backgroundColor,
    required String textColor,
  }) : super._(
         id: id,
         streamId: streamId,
         title: title,
         subtitle: subtitle,
         position: position,
         backgroundColor: backgroundColor,
         textColor: textColor,
       );

  /// Returns a shallow copy of this [OverlayPreset]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OverlayPreset copyWith({
    Object? id = _Undefined,
    String? streamId,
    String? title,
    String? subtitle,
    String? position,
    String? backgroundColor,
    String? textColor,
  }) {
    return OverlayPreset(
      id: id is int? ? id : this.id,
      streamId: streamId ?? this.streamId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      position: position ?? this.position,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
