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

abstract class FeaturedComment
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeaturedComment._({
    required this.streamId,
    required this.senderName,
    required this.message,
    required this.platform,
    this.avatarUrl,
    required this.isVisible,
  });

  factory FeaturedComment({
    required String streamId,
    required String senderName,
    required String message,
    required String platform,
    String? avatarUrl,
    required bool isVisible,
  }) = _FeaturedCommentImpl;

  factory FeaturedComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeaturedComment(
      streamId: jsonSerialization['streamId'] as String,
      senderName: jsonSerialization['senderName'] as String,
      message: jsonSerialization['message'] as String,
      platform: jsonSerialization['platform'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      isVisible: _is.BoolJsonExtension.fromJson(jsonSerialization['isVisible']),
    );
  }

  String streamId;

  String senderName;

  String message;

  String platform;

  String? avatarUrl;

  bool isVisible;

  /// Returns a shallow copy of this [FeaturedComment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeaturedComment copyWith({
    String? streamId,
    String? senderName,
    String? message,
    String? platform,
    String? avatarUrl,
    bool? isVisible,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeaturedComment',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      'platform': platform,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isVisible': isVisible,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeaturedComment',
      'streamId': streamId,
      'senderName': senderName,
      'message': message,
      'platform': platform,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'isVisible': isVisible,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeaturedCommentImpl extends FeaturedComment {
  _FeaturedCommentImpl({
    required String streamId,
    required String senderName,
    required String message,
    required String platform,
    String? avatarUrl,
    required bool isVisible,
  }) : super._(
         streamId: streamId,
         senderName: senderName,
         message: message,
         platform: platform,
         avatarUrl: avatarUrl,
         isVisible: isVisible,
       );

  /// Returns a shallow copy of this [FeaturedComment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeaturedComment copyWith({
    String? streamId,
    String? senderName,
    String? message,
    String? platform,
    Object? avatarUrl = _Undefined,
    bool? isVisible,
  }) {
    return FeaturedComment(
      streamId: streamId ?? this.streamId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      platform: platform ?? this.platform,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
