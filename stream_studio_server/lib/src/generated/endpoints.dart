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
import 'package:stream_studio_server/src/generated/overlay_preset.dart'
    as _iy80dre6;
import 'package:stream_studio_server/src/generated/stream_metadata.dart'
    as _ixrhpspk;
import 'package:stream_studio_server/src/generated/studio_message.dart'
    as _i85k0vcc;
import '../endpoints/overlay_preset_endpoint.dart' as _ixzjpcz1;
import '../endpoints/stream_metadata_endpoint.dart' as _ibhas1hg;
import '../endpoints/studio_endpoint.dart' as _i6hpvyvn;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'overlayPreset': _ixzjpcz1.OverlayPresetEndpoint()
        ..initialize(server, 'overlayPreset', null),
      'streamMetadata': _ibhas1hg.StreamMetadataEndpoint()
        ..initialize(server, 'streamMetadata', null),
      'studio': _i6hpvyvn.StudioEndpoint()..initialize(server, 'studio', null),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(server, 'greeting', null),
    };
    connectors['overlayPreset'] = _is.EndpointConnector(
      name: 'overlayPreset',
      endpoint: endpoints['overlayPreset']!,
      methodConnectors: {
        'savePreset': _is.MethodConnector(
          name: 'savePreset',
          params: {
            'preset': _is.ParameterDescription(
              name: 'preset',
              type: _is.getType<_iy80dre6.OverlayPreset>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['overlayPreset'] as _ixzjpcz1.OverlayPresetEndpoint)
                  .savePreset(session, params['preset']),
        ),
        'listPresets': _is.MethodConnector(
          name: 'listPresets',
          params: {
            'streamId': _is.ParameterDescription(
              name: 'streamId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['overlayPreset'] as _ixzjpcz1.OverlayPresetEndpoint)
                  .listPresets(session, params['streamId']),
        ),
        'deletePreset': _is.MethodConnector(
          name: 'deletePreset',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['overlayPreset'] as _ixzjpcz1.OverlayPresetEndpoint)
                  .deletePreset(session, params['id']),
        ),
      },
    );
    connectors['streamMetadata'] = _is.EndpointConnector(
      name: 'streamMetadata',
      endpoint: endpoints['streamMetadata']!,
      methodConnectors: {
        'saveMetadata': _is.MethodConnector(
          name: 'saveMetadata',
          params: {
            'metadata': _is.ParameterDescription(
              name: 'metadata',
              type: _is.getType<_ixrhpspk.StreamMetadata>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['streamMetadata'] as _ibhas1hg.StreamMetadataEndpoint)
                  .saveMetadata(session, params['metadata']),
        ),
        'getMetadata': _is.MethodConnector(
          name: 'getMetadata',
          params: {
            'streamId': _is.ParameterDescription(
              name: 'streamId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['streamMetadata'] as _ibhas1hg.StreamMetadataEndpoint)
                  .getMetadata(session, params['streamId']),
        ),
      },
    );
    connectors['studio'] = _is.EndpointConnector(
      name: 'studio',
      endpoint: endpoints['studio']!,
      methodConnectors: {
        'stream': _is.MethodStreamConnector(
          name: 'stream',
          params: {
            'streamId': _is.ParameterDescription(
              name: 'streamId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          streamParams: {
            'inbound': _is.StreamParameterDescription<_i85k0vcc.StudioMessage>(
              name: 'inbound',
              nullable: false,
            ),
          },
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['studio'] as _i6hpvyvn.StudioEndpoint).stream(
                session,
                streamParams['inbound']!.cast<_i85k0vcc.StudioMessage>(),
                params['streamId'],
              ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
  }
}
