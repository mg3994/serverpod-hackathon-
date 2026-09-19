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

abstract class BannerConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BannerConfig._({
    required this.streamId,
    required this.text,
    required this.isVisible,
    required this.isTicker,
    required this.backgroundColor,
    required this.textColor,
  });

  factory BannerConfig({
    required String streamId,
    required String text,
    required bool isVisible,
    required bool isTicker,
    required String backgroundColor,
    required String textColor,
  }) = _BannerConfigImpl;

  factory BannerConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return BannerConfig(
      streamId: jsonSerialization['streamId'] as String,
      text: jsonSerialization['text'] as String,
      isVisible: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isVisible'],
      ),
      isTicker: _isc.BoolJsonExtension.fromJson(jsonSerialization['isTicker']),
      backgroundColor: jsonSerialization['backgroundColor'] as String,
      textColor: jsonSerialization['textColor'] as String,
    );
  }

  String streamId;

  String text;

  bool isVisible;

  bool isTicker;

  String backgroundColor;

  String textColor;

  /// Returns a shallow copy of this [BannerConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BannerConfig copyWith({
    String? streamId,
    String? text,
    bool? isVisible,
    bool? isTicker,
    String? backgroundColor,
    String? textColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BannerConfig',
      'streamId': streamId,
      'text': text,
      'isVisible': isVisible,
      'isTicker': isTicker,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BannerConfig',
      'streamId': streamId,
      'text': text,
      'isVisible': isVisible,
      'isTicker': isTicker,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BannerConfigImpl extends BannerConfig {
  _BannerConfigImpl({
    required String streamId,
    required String text,
    required bool isVisible,
    required bool isTicker,
    required String backgroundColor,
    required String textColor,
  }) : super._(
         streamId: streamId,
         text: text,
         isVisible: isVisible,
         isTicker: isTicker,
         backgroundColor: backgroundColor,
         textColor: textColor,
       );

  /// Returns a shallow copy of this [BannerConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BannerConfig copyWith({
    String? streamId,
    String? text,
    bool? isVisible,
    bool? isTicker,
    String? backgroundColor,
    String? textColor,
  }) {
    return BannerConfig(
      streamId: streamId ?? this.streamId,
      text: text ?? this.text,
      isVisible: isVisible ?? this.isVisible,
      isTicker: isTicker ?? this.isTicker,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
