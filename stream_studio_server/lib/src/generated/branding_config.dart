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

abstract class BrandingConfig
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BrandingConfig._({
    required this.streamId,
    this.logoUrl,
    required this.logoPosition,
    required this.showLogo,
    required this.overlayColor,
  });

  factory BrandingConfig({
    required String streamId,
    String? logoUrl,
    required String logoPosition,
    required bool showLogo,
    required String overlayColor,
  }) = _BrandingConfigImpl;

  factory BrandingConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return BrandingConfig(
      streamId: jsonSerialization['streamId'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      logoPosition: jsonSerialization['logoPosition'] as String,
      showLogo: _is.BoolJsonExtension.fromJson(jsonSerialization['showLogo']),
      overlayColor: jsonSerialization['overlayColor'] as String,
    );
  }

  String streamId;

  String? logoUrl;

  String logoPosition;

  bool showLogo;

  String overlayColor;

  /// Returns a shallow copy of this [BrandingConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BrandingConfig copyWith({
    String? streamId,
    String? logoUrl,
    String? logoPosition,
    bool? showLogo,
    String? overlayColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BrandingConfig',
      'streamId': streamId,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'logoPosition': logoPosition,
      'showLogo': showLogo,
      'overlayColor': overlayColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BrandingConfig',
      'streamId': streamId,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'logoPosition': logoPosition,
      'showLogo': showLogo,
      'overlayColor': overlayColor,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BrandingConfigImpl extends BrandingConfig {
  _BrandingConfigImpl({
    required String streamId,
    String? logoUrl,
    required String logoPosition,
    required bool showLogo,
    required String overlayColor,
  }) : super._(
         streamId: streamId,
         logoUrl: logoUrl,
         logoPosition: logoPosition,
         showLogo: showLogo,
         overlayColor: overlayColor,
       );

  /// Returns a shallow copy of this [BrandingConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BrandingConfig copyWith({
    String? streamId,
    Object? logoUrl = _Undefined,
    String? logoPosition,
    bool? showLogo,
    String? overlayColor,
  }) {
    return BrandingConfig(
      streamId: streamId ?? this.streamId,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      logoPosition: logoPosition ?? this.logoPosition,
      showLogo: showLogo ?? this.showLogo,
      overlayColor: overlayColor ?? this.overlayColor,
    );
  }
}
