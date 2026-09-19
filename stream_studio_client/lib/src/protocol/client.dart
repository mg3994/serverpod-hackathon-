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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:stream_studio_client/src/protocol/greetings/greeting.dart'
    as _iryk0ksj;
import 'package:stream_studio_client/src/protocol/overlay_preset.dart'
    as _ii7eikmo;
import 'package:stream_studio_client/src/protocol/rtmp_destination.dart'
    as _ik58i5cj;
import 'package:stream_studio_client/src/protocol/stream_metadata.dart'
    as _iaurc9gq;
import 'package:stream_studio_client/src/protocol/studio_message.dart'
    as _i95d56sl;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointOverlayPreset extends _isc.EndpointRef {
  EndpointOverlayPreset(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'overlayPreset';

  /// Save a new overlay preset or update if existing ID provided
  _ida.Future<_ii7eikmo.OverlayPreset> savePreset(
    _ii7eikmo.OverlayPreset preset,
  ) => caller.callServerEndpoint<_ii7eikmo.OverlayPreset>(
    'overlayPreset',
    'savePreset',
    {'preset': preset},
  );

  /// List all overlay presets for a specific streamId
  _ida.Future<List<_ii7eikmo.OverlayPreset>> listPresets(String streamId) =>
      caller.callServerEndpoint<List<_ii7eikmo.OverlayPreset>>(
        'overlayPreset',
        'listPresets',
        {'streamId': streamId},
      );

  /// Delete an overlay preset by ID
  _ida.Future<bool> deletePreset(int id) => caller.callServerEndpoint<bool>(
    'overlayPreset',
    'deletePreset',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointRtmpDestination extends _isc.EndpointRef {
  EndpointRtmpDestination(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rtmpDestination';

  /// Save a new RTMP destination or update if existing ID provided
  _ida.Future<_ik58i5cj.RtmpDestination> saveDestination(
    _ik58i5cj.RtmpDestination destination,
  ) => caller.callServerEndpoint<_ik58i5cj.RtmpDestination>(
    'rtmpDestination',
    'saveDestination',
    {'destination': destination},
  );

  /// List all RTMP destinations for a specific streamId
  _ida.Future<List<_ik58i5cj.RtmpDestination>> listDestinations(
    String streamId,
  ) => caller.callServerEndpoint<List<_ik58i5cj.RtmpDestination>>(
    'rtmpDestination',
    'listDestinations',
    {'streamId': streamId},
  );

  /// Delete an RTMP destination by ID
  _ida.Future<bool> deleteDestination(int id) =>
      caller.callServerEndpoint<bool>(
        'rtmpDestination',
        'deleteDestination',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointStreamMetadata extends _isc.EndpointRef {
  EndpointStreamMetadata(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'streamMetadata';

  /// Save or update stream metadata
  _ida.Future<_iaurc9gq.StreamMetadata> saveMetadata(
    _iaurc9gq.StreamMetadata metadata,
  ) => caller.callServerEndpoint<_iaurc9gq.StreamMetadata>(
    'streamMetadata',
    'saveMetadata',
    {'metadata': metadata},
  );

  /// Get metadata for a specific streamId
  _ida.Future<_iaurc9gq.StreamMetadata?> getMetadata(String streamId) =>
      caller.callServerEndpoint<_iaurc9gq.StreamMetadata?>(
        'streamMetadata',
        'getMetadata',
        {'streamId': streamId},
      );
}

/// Real-time WebSocket endpoint that acts as a message bus for studio rooms.
///
/// Both the mobile camera source and the companion web studio connect here.
/// Every message sent by any client on [inbound] is broadcast to all other
/// clients subscribed to the same studio room channel.
///
/// The [streamId] query parameter identifies the room to join.
/// {@category Endpoint}
class EndpointStudio extends _isc.EndpointRef {
  EndpointStudio(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studio';

  /// Bidirectional stream method for the studio room.
  ///
  /// Clients send studio messages (e.g., [StudioMessage]) via [inbound]
  /// and receive messages from all other clients via the returned output stream.
  _ida.Stream<_i95d56sl.StudioMessage> stream(
    _ida.Stream<_i95d56sl.StudioMessage> inbound,
    String streamId,
  ) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_i95d56sl.StudioMessage>,
        _i95d56sl.StudioMessage
      >(
        'studio',
        'stream',
        {'streamId': streamId},
        {'inbound': inbound},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_iryk0ksj.Greeting> hello(String name) =>
      caller.callServerEndpoint<_iryk0ksj.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    overlayPreset = EndpointOverlayPreset(this);
    rtmpDestination = EndpointRtmpDestination(this);
    streamMetadata = EndpointStreamMetadata(this);
    studio = EndpointStudio(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointOverlayPreset overlayPreset;

  late final EndpointRtmpDestination rtmpDestination;

  late final EndpointStreamMetadata streamMetadata;

  late final EndpointStudio studio;

  late final EndpointGreeting greeting;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'overlayPreset': overlayPreset,
    'rtmpDestination': rtmpDestination,
    'streamMetadata': streamMetadata,
    'studio': studio,
    'greeting': greeting,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}
