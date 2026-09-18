import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:stream_studio_client/stream_studio_client.dart';

class StudioController extends ChangeNotifier {
  final Client client;
  final String streamId;

  final StreamController<StudioMessage> _outboundController =
      StreamController<StudioMessage>.broadcast();
  StreamSubscription<StudioMessage>? _inboundSubscription;

  final StreamController<StudioMessage> _incomingMessages =
      StreamController<StudioMessage>.broadcast();
  Stream<StudioMessage> get messages => _incomingMessages.stream;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  StudioController({required this.client, required this.streamId});

  void connect() {
    try {
      final inStream = client.studio.stream(
        _outboundController.stream,
        streamId,
      );
      _inboundSubscription = inStream.listen(
        (msg) {
          _isConnected = true;
          _incomingMessages.add(msg);
          notifyListeners();
        },
        onError: (err) {
          _isConnected = false;
          notifyListeners();
        },
        onDone: () {
          _isConnected = false;
          notifyListeners();
        },
      );
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      notifyListeners();
    }
  }

  void _send(StudioMessage msg) {
    if (!_outboundController.isClosed) {
      _outboundController.add(msg);
    }
  }

  /// Broadcasts lower-third overlay changes to connected camera feeds
  Future<void> sendOverlay({
    required String title,
    required String subtitle,
    required bool isVisible,
    String position = 'lower_third',
    String backgroundColor = '#E50914',
    String textColor = '#FFFFFF',
    String animationStyle = 'fade',
  }) async {
    final overlay = OverlayConfig(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      streamId: streamId,
      title: title,
      subtitle: subtitle,
      position: position,
      isVisible: isVisible,
      backgroundColor: backgroundColor,
      textColor: textColor,
      animationStyle: animationStyle,
    );

    _send(
      StudioMessage(
        streamId: streamId,
        type: 'overlay_config',
        overlayConfig: overlay,
      ),
    );
  }

  /// Sends remote camera adjustments (Zoom, Torch toggle, camera switcher, mic mute)
  Future<void> updateCameraHardware({
    required double zoomLevel,
    required bool torchOn,
    int activeCameraIndex = 0,
    bool isMuted = false,
  }) async {
    final control = CameraControl(
      streamId: streamId,
      torchOn: torchOn,
      zoomLevel: zoomLevel,
      activeCameraIndex: activeCameraIndex,
      isMuted: isMuted,
    );

    _send(
      StudioMessage(
        streamId: streamId,
        type: 'camera_control',
        cameraControl: control,
      ),
    );
  }

  /// Sends scene switching commands (Camera, Color Bars, Black Slate)
  Future<void> sendSceneControl({
    required String activeScene,
    String transitionType = 'fade',
  }) async {
    final scene = SceneControl(
      streamId: streamId,
      activeScene: activeScene,
      transitionType: transitionType,
    );

    _send(
      StudioMessage(
        streamId: streamId,
        type: 'scene_control',
        sceneControl: scene,
      ),
    );
  }

  /// Sends producer chat / teleprompter cue messages
  Future<void> sendChatMessage({
    required String senderName,
    required String message,
    bool isDirectorCue = false,
  }) async {
    final chatMsg = StudioChatMessage(
      streamId: streamId,
      senderName: senderName,
      message: message,
      timestamp: DateTime.now().toUtc(),
      isDirectorCue: isDirectorCue,
    );

    _send(
      StudioMessage(
        streamId: streamId,
        type: 'chat',
        chatMessage: chatMsg,
      ),
    );
  }

  /// Sends heartbeat metrics to the director
  Future<void> sendHeartbeat(StreamHeartbeat heartbeat) async {
    _send(
      StudioMessage(
        streamId: streamId,
        type: 'heartbeat',
        heartbeat: heartbeat,
      ),
    );
  }

  /// Sends a WebRTC signaling message
  Future<void> sendSignalingMessage(SignalingMessage signalingMessage) async {
    _send(
      StudioMessage(
        streamId: streamId,
        type: 'signaling',
        signalingMessage: signalingMessage,
      ),
    );
  }

  /// Stream metadata operations
  Future<StreamMetadata?> getMetadata() async {
    return await client.streamMetadata.getMetadata(streamId);
  }

  Future<StreamMetadata> saveMetadata({
    required String title,
    required String description,
    required bool isLive,
  }) async {
    final existing = await getMetadata();
    final metadata = StreamMetadata(
      id: existing?.id,
      streamId: streamId,
      title: title,
      description: description,
      isLive: isLive,
      viewerCount: existing?.viewerCount ?? 1,
      startedAt: isLive
          ? (existing?.startedAt ?? DateTime.now().toUtc())
          : null,
    );
    return await client.streamMetadata.saveMetadata(metadata);
  }

  /// Preset operations using PostgreSQL ORM endpoint
  Future<OverlayPreset> savePreset(OverlayPreset preset) async {
    return await client.overlayPreset.savePreset(preset);
  }

  Future<List<OverlayPreset>> listPresets() async {
    return await client.overlayPreset.listPresets(streamId);
  }

  Future<bool> deletePreset(int id) async {
    return await client.overlayPreset.deletePreset(id);
  }

  void dispose() {
    _inboundSubscription?.cancel();
    _outboundController.close();
    _incomingMessages.close();
    super.dispose();
  }
}
