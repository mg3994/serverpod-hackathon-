import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:stream_studio_client/stream_studio_client.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class StudioController extends ChangeNotifier {
  final Client client;
  final String streamId;
  String? ownDeviceId;

  final StreamController<StudioMessage> _outboundController =
      StreamController<StudioMessage>.broadcast();
  StreamSubscription<StudioMessage>? _inboundSubscription;

  final StreamController<StudioMessage> _incomingMessages =
      StreamController<StudioMessage>.broadcast();
  Stream<StudioMessage> get messages => _incomingMessages.stream;

  final Map<String, StreamHeartbeat> _activeDevices = {};
  Map<String, StreamHeartbeat> get activeDevices => Map.unmodifiable(_activeDevices);

  // WebRTC Management
  final Map<String, RTCPeerConnection> _peerConnections = {};
  final Map<String, RTCVideoRenderer> _remoteRenderers = {};
  Map<String, RTCVideoRenderer> get remoteRenderers => _remoteRenderers;

  MediaStream? _localStream;
  RTCVideoRenderer? _localRenderer;
  RTCVideoRenderer? get localRenderer => _localRenderer;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ]
  };

  Timer? _cleanupTimer;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  bool _isBroadcasting = false;
  bool get isBroadcasting => _isBroadcasting;

  String? _programDeviceId;
  String? get programDeviceId => _programDeviceId;

  String _activeScene = 'camera';
  String get activeScene => _activeScene;

  String _layout = 'solo';
  String get layout => _layout;

  List<String> _stageDeviceIds = [];
  List<String> get stageDeviceIds => List.unmodifiable(_stageDeviceIds);

  FeaturedComment? _activeFeaturedComment;
  FeaturedComment? get activeFeaturedComment => _activeFeaturedComment;

  BrandingConfig? _brandingConfig;
  BrandingConfig? get brandingConfig => _brandingConfig;

  BannerConfig? _bannerConfig;
  BannerConfig? get bannerConfig => _bannerConfig;

  final Map<String, List<StudioChatMessage>> _privateMessages = {};
  Map<String, List<StudioChatMessage>> get privateMessages => _privateMessages;

  StudioController({required this.client, required this.streamId}) {
    _startCleanupTimer();
  }

  void _startCleanupTimer() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      final now = DateTime.now().toUtc();
      bool changed = false;
      _activeDevices.removeWhere((id, heartbeat) {
        final isStale = now.difference(heartbeat.timestamp).inSeconds > 15;
        if (isStale) {
          changed = true;
          _closePeerConnection(id);
        }
        return isStale;
      });
      if (changed) notifyListeners();
    });
  }

  void _closePeerConnection(String deviceId) {
    _peerConnections[deviceId]?.close();
    _peerConnections.remove(deviceId);
    _remoteRenderers[deviceId]?.dispose();
    _remoteRenderers.remove(deviceId);
  }

  int _reconnectAttempts = 0;
  Timer? _reconnectTimer;

  void connect() {
    _reconnectTimer?.cancel();
    try {
      final inStream = client.studio.stream(
        _outboundController.stream,
        streamId,
      );
      _inboundSubscription = inStream.listen(
        (msg) {
          // Ignore messages sent by ourselves
          if (ownDeviceId != null) {
            bool isSelf = false;
            if (msg.chatMessage?.senderName == ownDeviceId) isSelf = true;
            if (msg.heartbeat?.deviceId == ownDeviceId) isSelf = true;
            if (msg.signalingMessage?.senderId == ownDeviceId) isSelf = true;
            if (isSelf) return;
          }

          _isConnected = true;
          _reconnectAttempts = 0;
          if (msg.heartbeat != null) {
            _activeDevices[msg.heartbeat!.deviceId] = msg.heartbeat!;
            notifyListeners();
          }
          if (msg.broadcastControl != null) {
            _isBroadcasting = msg.broadcastControl!.command == 'start';
            notifyListeners();
          }
          if (msg.sceneControl != null) {
            _activeScene = msg.sceneControl!.activeScene;
            _layout = msg.sceneControl!.layout;
            _stageDeviceIds = msg.sceneControl!.stageDeviceIds;
            if (msg.sceneControl!.programDeviceId != null) {
              _programDeviceId = msg.sceneControl!.programDeviceId;
            }
            notifyListeners();
          }
          if (msg.chatMessage != null) {
            final chat = msg.chatMessage!;
            if (chat.isPrivate == true) {
              final convoId = (chat.senderName == (ownDeviceId ?? 'dashboard'))
                  ? chat.targetDeviceId!
                  : chat.senderName;

              _privateMessages.putIfAbsent(convoId, () => []);
              _privateMessages[convoId]!.add(chat);
              notifyListeners();
            }
          }
          if (msg.featuredComment != null) {
            _activeFeaturedComment = msg.featuredComment;
            notifyListeners();
          }
          if (msg.brandingConfig != null) {
            _brandingConfig = msg.brandingConfig;
            notifyListeners();
          }
          if (msg.bannerConfig != null) {
            _bannerConfig = msg.bannerConfig;
            notifyListeners();
          }
          if (msg.signalingMessage != null) {
            _handleSignalingInternal(msg.signalingMessage!);
          }
          _incomingMessages.add(msg);
          notifyListeners();
        },
        onError: (err) {
          _isConnected = false;
          _scheduleReconnect();
          notifyListeners();
        },
        onDone: () {
          _isConnected = false;
          _scheduleReconnect();
          notifyListeners();
        },
      );
      _isConnected = true;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      _scheduleReconnect();
      notifyListeners();
    }
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts > 10) return; // Cap attempts
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      Duration(seconds: min(2 + _reconnectAttempts * 2, 30)),
      () {
        _reconnectAttempts++;
        connect();
      },
    );
  }

  // --- WebRTC Signaling Logic ---

  Future<void> _handleSignalingInternal(SignalingMessage signaling) async {
    // Only handle messages directed to us
    if (signaling.targetId != (ownDeviceId ?? 'dashboard')) return;

    if (signaling.type == 'offer') {
      await _handleOffer(signaling);
    } else if (signaling.type == 'answer') {
      await _handleAnswer(signaling);
    } else if (signaling.type == 'candidate') {
      await _handleCandidate(signaling);
    }
  }

  Future<void> _handleOffer(SignalingMessage signaling) async {
    final pc = await _getOrCreatePC(signaling.senderId);
    await pc.setRemoteDescription(
      RTCSessionDescription(signaling.sdp!, signaling.type),
    );
    final answer = await pc.createAnswer();
    await pc.setLocalDescription(answer);

    sendSignalingMessage(SignalingMessage(
      senderId: ownDeviceId ?? 'dashboard', 
      targetId: signaling.senderId,
      type: 'answer',
      sdp: answer.sdp,
    ));
  }

  Future<void> _handleAnswer(SignalingMessage signaling) async {
    final pc = _peerConnections[signaling.senderId];
    if (pc != null) {
      await pc.setRemoteDescription(
        RTCSessionDescription(signaling.sdp!, signaling.type),
      );
    }
  }

  Future<void> _handleCandidate(SignalingMessage signaling) async {
    final pc = await _getOrCreatePC(signaling.senderId);
    await pc.addCandidate(
      RTCIceCandidate(
        signaling.candidate!,
        signaling.sdpMid!,
        signaling.sdpMLineIndex!,
      ),
    );
  }

  Future<RTCPeerConnection> _getOrCreatePC(String deviceId) async {
    if (_peerConnections.containsKey(deviceId)) {
      return _peerConnections[deviceId]!;
    }

    final pc = await createPeerConnection(_iceServers);
    _peerConnections[deviceId] = pc;

    pc.onIceCandidate = (candidate) {
      sendSignalingMessage(SignalingMessage(
        senderId: ownDeviceId ?? 'dashboard', 
        targetId: deviceId,
        type: 'candidate',
        candidate: candidate.candidate,
        sdpMid: candidate.sdpMid,
        sdpMLineIndex: candidate.sdpMLineIndex,
      ));
    };

    pc.onTrack = (event) async {
      if (event.streams.isNotEmpty) {
        final renderer = RTCVideoRenderer();
        await renderer.initialize();
        renderer.srcObject = event.streams[0];
        _remoteRenderers[deviceId] = renderer;
        notifyListeners();
      }
    };

    return pc;
  }

  // --- Camera Source Methods ---

  Future<void> startLocalStream(MediaStream stream) async {
    _localStream = stream;
    _localRenderer = RTCVideoRenderer();
    await _localRenderer!.initialize();
    _localRenderer!.srcObject = _localStream;
    notifyListeners();
  }

  Future<void> createOffer(String deviceId, String targetId) async {
    ownDeviceId = deviceId;
    final pc = await _getOrCreatePC(targetId);
    
    if (_localStream != null) {
      for (var track in _localStream!.getTracks()) {
        await pc.addTrack(track, _localStream!);
      }
    }

    final offer = await pc.createOffer();
    await pc.setLocalDescription(offer);

    sendSignalingMessage(SignalingMessage(
      senderId: deviceId,
      targetId: targetId,
      type: 'offer',
      sdp: offer.sdp,
    ));
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
    String? targetDeviceId,
    required double zoomLevel,
    required bool torchOn,
    int activeCameraIndex = 0,
    bool isMuted = false,
  }) async {
    final control = CameraControl(
      streamId: streamId,
      targetDeviceId: targetDeviceId,
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
    String? targetDeviceId,
    String? programDeviceId,
    required String activeScene,
    String layout = 'solo',
    List<String> stageDeviceIds = const [],
    String transitionType = 'fade',
  }) async {
    final scene = SceneControl(
      streamId: streamId,
      targetDeviceId: targetDeviceId,
      programDeviceId: programDeviceId,
      activeScene: activeScene,
      layout: layout,
      stageDeviceIds: stageDeviceIds,
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
    bool isPrivate = false,
    String? targetDeviceId,
  }) async {
    final chatMsg = StudioChatMessage(
      streamId: streamId,
      senderName: senderName,
      message: message,
      timestamp: DateTime.now().toUtc(),
      isDirectorCue: isDirectorCue,
      isPrivate: isPrivate,
      targetDeviceId: targetDeviceId,
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

  /// Sends a featured comment command to all clients
  void sendFeaturedComment(FeaturedComment comment) {
    _send(
      StudioMessage(
        streamId: streamId,
        type: 'featured_comment',
        featuredComment: comment,
      ),
    );
  }

  /// Sends a branding configuration update
  void updateBranding(BrandingConfig config) {
    _send(
      StudioMessage(
        streamId: streamId,
        type: 'branding',
        brandingConfig: config,
      ),
    );
  }

  /// Sends a banner update
  void updateBanner(BannerConfig config) {
    _send(
      StudioMessage(
        streamId: streamId,
        type: 'banner',
        bannerConfig: config,
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

  /// RTMP Broadcast Operations
  Future<RtmpDestination> saveRtmpDestination(RtmpDestination dest) async {
    return await client.rtmpDestination.saveDestination(dest);
  }

  Future<List<RtmpDestination>> listRtmpDestinations() async {
    return await client.rtmpDestination.listDestinations(streamId);
  }

  Future<bool> deleteRtmpDestination(int id) async {
    return await client.rtmpDestination.deleteDestination(id);
  }

  Future<void> sendBroadcastCommand({
    required String command,
    int? destinationId,
  }) async {
    final broadcast = BroadcastControl(
      streamId: streamId,
      command: command,
      destinationId: destinationId,
    );

    _send(
      StudioMessage(
        streamId: streamId,
        type: 'broadcast',
        broadcastControl: broadcast,
      ),
    );
  }

  @override
  void dispose() {
    _cleanupTimer?.cancel();
    _reconnectTimer?.cancel();
    _inboundSubscription?.cancel();
    _outboundController.close();
    _incomingMessages.close();
    super.dispose();
  }
}
