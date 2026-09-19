import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stream_studio_client/stream_studio_client.dart';
import '../controllers/studio_controller.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CompanionStudioView extends StatefulWidget {
  final Client client;
  final String streamId;

  const CompanionStudioView({
    super.key,
    required this.client,
    required this.streamId,
  });

  @override
  State<CompanionStudioView> createState() => _CompanionStudioViewState();
}

class _CompanionStudioViewState extends State<CompanionStudioView> {
  late StudioController _controller;
  StreamSubscription<StudioMessage>? _messageSubscription;

  // Connection State & Telemetry
  bool _isConnected = false;
  String? _selectedDeviceId;

  // Stream Metadata State
  final _streamTitleController = TextEditingController(
    text: 'Live Studio Broadcast',
  );
  final _streamDescController = TextEditingController(
    text: 'Streaming via StreamStudio Serverpod engine',
  );
  bool _isBroadcastingLive = false;

  // Active Scene State
  String _activeScene = 'camera'; // "camera", "color_bars", "black_slate"

  // Chat & Teleprompter Cue State
  final _chatInputController = TextEditingController();
  final List<StudioChatMessage> _chatMessages = [];

  // Lower-Third Editor Form State
  final _titleController = TextEditingController(text: 'Live Studio News');
  final _subtitleController = TextEditingController(
    text: 'Reporting live from Companion Dashboard',
  );
  String _selectedPosition = 'lower_third';
  String _backgroundColorHex = '#E50914';
  String _textColorHex = '#FFFFFF';
  String _selectedAnimationStyle = 'fade';
  bool _isOverlayVisible = false;

  // Remote Camera Controls State
  double _zoomLevel = 1.0;
  bool _torchOn = false;
  bool _isAudioMuted = false;
  int _activeCameraIndex = 0; // 0 = Back, 1 = Front

  // Overlay Presets
  List<OverlayPreset> _presets = [];

  // RTMP Destinations
  List<RtmpDestination> _rtmpDestinations = [];
  final _rtmpUrlController = TextEditingController();
  final _rtmpKeyController = TextEditingController();
  String _rtmpPlatform = 'YouTube';

  // Branding State
  final _logoUrlController = TextEditingController(
    text: 'https://serverpod.dev/assets/img/serverpod-logo-white.png',
  );
  String _brandingColorHex = '#3B82F6';
  bool _showLogo = true;

  // Banners State
  final _bannerTextController = TextEditingController(text: 'Welcome to StreamStudio!');
  bool _bannerVisible = false;
  bool _bannerIsTicker = false;

  final String _companionId =
      'studio_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

  @override
  void initState() {
    super.initState();
    _controller = StudioController(
      client: widget.client,
      streamId: widget.streamId,
    );
    _controller.ownDeviceId = 'dashboard';
    _initStudio();
  }

  Future<void> _initStudio() async {
    _controller.connect();

    _messageSubscription = _controller.messages.listen((msg) {
      if (!mounted) return;

      setState(() => _isConnected = true);

      if (msg.sceneControl != null) {
        setState(() => _activeScene = msg.sceneControl!.activeScene);
      } else if (msg.chatMessage != null) {
        setState(() => _chatMessages.add(msg.chatMessage!));
      } else if (msg.overlayConfig != null) {
        final overlay = msg.overlayConfig!;
        setState(() {
          _isOverlayVisible = overlay.isVisible;
          _titleController.text = overlay.title;
          _subtitleController.text = overlay.subtitle;
          _selectedPosition = overlay.position;
          _backgroundColorHex = overlay.backgroundColor;
          _textColorHex = overlay.textColor;
          _selectedAnimationStyle = overlay.animationStyle ?? 'fade';
        });
      } else if (msg.cameraControl != null) {
        final camera = msg.cameraControl!;
        setState(() {
          _zoomLevel = camera.zoomLevel;
          _torchOn = camera.torchOn;
          _activeCameraIndex = camera.activeCameraIndex;
          if (camera.isMuted != null) {
            _isAudioMuted = camera.isMuted!;
          }
        });
      }
    });

    _loadMetadata();
    _loadPresets();
    _loadRtmpDestinations();
  }

  Future<void> _loadRtmpDestinations() async {
    try {
      final list = await _controller.listRtmpDestinations();
      if (mounted) {
        setState(() => _rtmpDestinations = list);
      }
    } catch (e) {
      debugPrint('Error loading RTMP destinations: $e');
    }
  }

  Future<void> _loadMetadata() async {
    try {
      final meta = await _controller.getMetadata();
      if (meta != null && mounted) {
        setState(() {
          _streamTitleController.text = meta.title;
          _streamDescController.text = meta.description;
          _isBroadcastingLive = meta.isLive;
        });
      }
    } catch (e) {
      debugPrint('Error loading stream metadata: $e');
    }
  }

  Future<void> _loadPresets() async {
    try {
      final list = await _controller.listPresets();
      if (mounted) {
        setState(() => _presets = list);
      }
    } catch (e) {
      debugPrint('Error loading overlay presets: $e');
    }
  }

  void _openPrivateChat(String deviceId) {
    showDialog(
      context: context,
      builder: (context) {
        final chatController = TextEditingController();
        return ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final messages = _controller.privateMessages[deviceId] ?? [];
            return AlertDialog(
              backgroundColor: const Color(0xff1e1e1e),
              title: Text('Private Chat with $deviceId', style: const TextStyle(color: Colors.white, fontSize: 14)),
              content: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, i) {
                          final m = messages[i];
                          final isMe = m.senderName == (_controller.ownDeviceId ?? 'dashboard');
                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isMe ? Colors.blue[900] : Colors.grey[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(m.message, style: const TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatController,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              hintText: 'Type message...',
                              filled: true,
                              fillColor: Color(0xff2a2a2a),
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (_) {
                              final text = chatController.text.trim();
                              if (text.isEmpty) return;
                              _controller.sendChatMessage(
                                senderName: _controller.ownDeviceId ?? 'dashboard',
                                message: text,
                                isPrivate: true,
                                targetDeviceId: deviceId,
                              );
                              chatController.clear();
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: () {
                            final text = chatController.text.trim();
                            if (text.isEmpty) return;
                            _controller.sendChatMessage(
                              senderName: _controller.ownDeviceId ?? 'dashboard',
                              message: text,
                              isPrivate: true,
                              targetDeviceId: deviceId,
                            );
                            chatController.clear();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
              ],
            );
          },
        );
      },
    );
  }

  void _pushOverlayLive(bool visible) {
    setState(() => _isOverlayVisible = visible);
    _controller.sendOverlay(
      title: _titleController.text,
      subtitle: _subtitleController.text,
      isVisible: visible,
      position: _selectedPosition,
      backgroundColor: _backgroundColorHex,
      textColor: _textColorHex,
      animationStyle: _selectedAnimationStyle,
    );
  }

  void _updateCameraControl() {
    _controller.updateCameraHardware(
      targetDeviceId: _selectedDeviceId,
      zoomLevel: _zoomLevel,
      torchOn: _torchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _requestP2PStream() {
    final target = _selectedDeviceId ??
        (_controller.activeDevices.isNotEmpty
            ? _controller.activeDevices.keys.first
            : null);
    if (target == null) return;

    _controller.sendSignalingMessage(
      SignalingMessage(
        senderId: _controller.ownDeviceId ?? 'dashboard',
        targetId: target,
        type: 'request',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Requesting P2P stream from $target...')),
    );
  }

  void _toggleStage(String deviceId) {
    final currentStage = List<String>.from(_controller.stageDeviceIds);
    if (currentStage.contains(deviceId)) {
      currentStage.remove(deviceId);
    } else {
      currentStage.add(deviceId);
    }

    _controller.sendSceneControl(
      activeScene: 'camera',
      layout: currentStage.length > 1 ? 'grid' : 'solo',
      stageDeviceIds: currentStage,
      programDeviceId: currentStage.isNotEmpty ? currentStage.first : null,
    );
  }

  void _setLayout(String layout) {
    _controller.sendSceneControl(
      activeScene: 'camera',
      layout: layout,
      stageDeviceIds: _controller.stageDeviceIds,
      programDeviceId: _controller.programDeviceId,
    );
  }

  void _switchScene(String scene) {
    _controller.sendSceneControl(
      targetDeviceId: _selectedDeviceId,
      programDeviceId: _selectedDeviceId,
      activeScene: scene,
      layout: _controller.layout,
      stageDeviceIds: _controller.stageDeviceIds,
    );
  }

  void _sendProducerChat({required bool isCue}) {
    final text = _chatInputController.text.trim();
    if (text.isEmpty) return;
    _chatInputController.clear();

    _controller.sendChatMessage(
      senderName: 'Director / Companion',
      message: text,
      isDirectorCue: isCue,
    );
  }

  void _applyQuickTemplate(
    String title,
    String subtitle,
    String position,
    String color,
    String anim,
  ) {
    setState(() {
      _titleController.text = title;
      _subtitleController.text = subtitle;
      _selectedPosition = position;
      _backgroundColorHex = color;
      _selectedAnimationStyle = anim;
    });
    _pushOverlayLive(true);
  }

  void _featureComment(StudioChatMessage chatMsg) {
    final featured = FeaturedComment(
      streamId: widget.streamId,
      senderName: chatMsg.senderName,
      message: chatMsg.message,
      platform: chatMsg.platform ?? 'director',
      avatarUrl: chatMsg.avatarUrl,
      isVisible: true,
    );
    _controller.sendFeaturedComment(featured);
  }

  void _takeDownFeaturedComment() {
    if (_controller.activeFeaturedComment != null) {
      final featured =
          _controller.activeFeaturedComment!.copyWith(isVisible: false);
      _controller.sendFeaturedComment(featured);
    }
  }

  void _updateBranding() {
    final config = BrandingConfig(
      streamId: widget.streamId,
      logoUrl: _logoUrlController.text,
      logoPosition: 'top_right',
      showLogo: _showLogo,
      overlayColor: _brandingColorHex,
    );
    _controller.updateBranding(config);
  }

  void _updateBanner() {
    final config = BannerConfig(
      streamId: widget.streamId,
      text: _bannerTextController.text,
      isVisible: _bannerVisible,
      isTicker: _bannerIsTicker,
      backgroundColor: _brandingColorHex,
      textColor: '#FFFFFF',
    );
    _controller.updateBanner(config);
  }

  Widget _buildBannersPanel() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.flag, color: Colors.blueAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Banners',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _bannerVisible ? Colors.grey[700] : Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {
                    setState(() => _bannerVisible = !_bannerVisible);
                    _updateBanner();
                  },
                  child: Text(_bannerVisible ? 'HIDE' : 'SHOW', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bannerTextController,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'Banner Text',
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_bannerVisible) _updateBanner();
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Ticker Mode', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const Spacer(),
                Switch(
                  value: _bannerIsTicker,
                  onChanged: (val) {
                    setState(() => _bannerIsTicker = val);
                    _updateBanner();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandingPanel() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.brush, color: Colors.pinkAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Branding & Logos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: _showLogo,
                  activeThumbColor: Colors.pinkAccent,
                  onChanged: (val) {
                    setState(() => _showLogo = val);
                    _updateBranding();
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _logoUrlController,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              decoration: const InputDecoration(
                labelText: 'Logo Image URL',
                labelStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => _updateBranding(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Brand Color',
              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildColorOption('#3B82F6', Colors.blue),
                _buildColorOption('#EF4444', Colors.red),
                _buildColorOption('#10B981', Colors.green),
                _buildColorOption('#F59E0B', Colors.orange),
                _buildColorOption('#8B5CF6', Colors.purple),
                _buildColorOption('#EC4899', Colors.pink),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(String hex, Color color) {
    final isSelected = _brandingColorHex == hex;
    return GestureDetector(
      onTap: () {
        setState(() => _brandingColorHex = hex);
        _updateBranding();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected 
              ? Border.all(color: Colors.white, width: 2)
              : null,
          boxShadow: isSelected ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8)] : null,
        ),
      ),
    );
  }

  Widget _buildAudioVuMeter(double level) {
    final clampedLevel = level.clamp(0.0, 1.0);
    final color = clampedLevel > 0.8
        ? Colors.redAccent
        : clampedLevel > 0.5
        ? Colors.amberAccent
        : Colors.greenAccent;

    return Container(
      width: 80,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: clampedLevel,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Color _parseColor(String? hexString, Color fallback) {
    if (hexString == null || hexString.isEmpty) return fallback;
    try {
      final cleanHex = hexString.replaceFirst('#', '');
      if (cleanHex.length == 6) {
        return Color(int.parse('0xff$cleanHex'));
      } else if (cleanHex.length == 8) {
        return Color(int.parse('0x$cleanHex'));
      }
    } catch (_) {}
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1e1e),
        title: Text('StreamStudio Dashboard (${widget.streamId})'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: _isConnected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _isConnected ? 'BROADCAST STUDIO' : 'CONNECTING',
                  style: TextStyle(
                    color: _isConnected ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(flex: 2, child: _buildPreviewViewport()),
                              Expanded(flex: 1, child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: _buildBackstageArea(),
                              )),
                            ],
                          ),
                        ),
                        Expanded(flex: 2, child: _buildControlPanel()),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 380, child: _buildPreviewViewport()),
                          _buildBackstageArea(),
                          _buildControlPanel(),
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  Widget _buildBackstageArea() {
    return Card(
      color: const Color(0xff1a1a1a),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.video_camera_back, color: Colors.blueAccent, size: 18),
                SizedBox(width: 8),
                Text(
                  'BACKSTAGE (GUESTS)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _controller.activeDevices.isEmpty
                  ? const Center(
                      child: Text(
                        'WAITING FOR GUESTS TO CONNECT...',
                        style: TextStyle(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.activeDevices.length,
                      itemBuilder: (context, index) {
                  final deviceId = _controller.activeDevices.keys.elementAt(index);
                  final heartbeat = _controller.activeDevices[deviceId]!;
                  final isSelected = _selectedDeviceId == deviceId;
                  final isOnStage = _controller.stageDeviceIds.contains(deviceId);

                  return GestureDetector(
                    onTap: () => setState(() => _selectedDeviceId = deviceId),
                    child: Container(
                      width: 180,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isOnStage
                              ? Colors.blue
                              : isSelected
                                  ? Colors.green
                                  : Colors.white12,
                          width: 2,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          // WebRTC Video Feed
                          if (_controller.remoteRenderers.containsKey(deviceId))
                            RTCVideoView(
                              _controller.remoteRenderers[deviceId]!,
                              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                            )
                          else
                            Center(
                              child: Icon(
                                Icons.videocam,
                                color: isOnStage
                                    ? Colors.blue
                                    : isSelected
                                        ? Colors.green
                                        : Colors.white24,
                                size: 32,
                              ),
                            ),
                          
                          // Stage Label
                          if (isOnStage)
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                color: Colors.blue,
                                child: const Text(
                                  'ON STAGE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  color: Colors.black54,
                                  child: Text(
                                    deviceId,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => _toggleStage(deviceId),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4),
                                    color: isOnStage 
                                        ? Colors.grey.withValues(alpha: 0.8)
                                        : Colors.blue.withValues(alpha: 0.8),
                                    child: Text(
                                      isOnStage ? 'REMOVE' : 'ADD TO STAGE',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.forum, size: 14, color: Colors.white70),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () => _openPrivateChat(deviceId),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: heartbeat.audioLevel != null &&
                                          heartbeat.audioLevel! > 0.1
                                      ? Colors.green
                                      : Colors.white24,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewViewport() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        children: [
          // Scene View Simulator
          Center(
            child: _activeScene == 'black_slate'
                ? const Text(
                    '● BLACK SLATE ACTIVE',
                    style: TextStyle(
                      color: Colors.white24,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : _activeScene == 'color_bars'
                ? Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(color: const Color(0xffc0c0c0)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xffc0c000)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xff00c0c0)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xff00c000)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xffc000c0)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xffc00000)),
                            ),
                            Expanded(
                              child: Container(color: const Color(0xff0000c0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          alignment: Alignment.center,
                          child: const Text(
                            'SMPTE COLOR BARS • STANDBY SLATE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: _buildStageLayout(),
                  ),
          ),

          // Tally Indicator & Source Selector
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _controller.isBroadcasting
                        ? 'ON AIR (${_activeScene.toUpperCase()})'
                        : 'STANDBY (${_activeScene.toUpperCase()})',
                    style: TextStyle(
                      color: _controller.isBroadcasting ? Colors.red : Colors.amber,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_controller.activeDevices.length > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDeviceId ??
                            _controller.activeDevices.keys.first,
                        dropdownColor: Colors.black87,
                        isDense: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        items: _controller.activeDevices.keys.map((id) {
                          return DropdownMenuItem(
                            value: id,
                            child: Text('SOURCE: $id'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => _selectedDeviceId = val);
                        },
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                if (_controller.activeDevices.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.cast, color: Colors.blueAccent),
                    onPressed: _requestP2PStream,
                    tooltip: 'Request P2P Monitoring Stream',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
              ],
            ),
          ),

          // Lower Third Live Graphic Preview
          if (_isOverlayVisible)
            Positioned.fill(
              child: Align(
                alignment: _selectedPosition == 'top_right'
                    ? Alignment.topRight
                    : _selectedPosition == 'ticker'
                    ? Alignment.bottomCenter
                    : Alignment.bottomLeft,
                child: Padding(
                  padding: _selectedPosition == 'ticker'
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _parseColor(
                        _backgroundColorHex,
                        const Color(0xffe50914),
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(color: Colors.black54, blurRadius: 8),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _titleController.text,
                          style: TextStyle(
                            color: _parseColor(_textColorHex, Colors.white),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (_subtitleController.text.isNotEmpty)
                          Text(
                            _subtitleController.text,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Heartbeat HUD (Bottom Right)
          if (_selectedDeviceId != null || _controller.activeDevices.isNotEmpty)
            Positioned(
              bottom: 12,
              right: 12,
              child: _buildHeartbeatHud(),
            ),
        ],
      ),
    );
  }

  Widget _buildStageLayout() {
    final stageIds = _controller.stageDeviceIds;
    if (stageIds.isEmpty) {
      return const Center(
        child: Text(
          'STAGING AREA EMPTY',
          style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold),
        ),
      );
    }

    if (_controller.layout == 'solo' || stageIds.length == 1) {
      final deviceId = _controller.programDeviceId ?? stageIds.first;
      return _buildRemoteVideo(deviceId);
    }

    if (_controller.layout == 'grid') {
      return GridView.builder(
        padding: const EdgeInsets.all(4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: stageIds.length > 2 ? 2 : stageIds.length,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.6,
        ),
        itemCount: stageIds.length,
        itemBuilder: (context, i) => _buildRemoteVideo(stageIds[i]),
      );
    }

    if (_controller.layout == 'pip') {
      return Stack(
        children: [
          _buildRemoteVideo(stageIds.first),
          if (stageIds.length > 1)
            Positioned(
              right: 16,
              bottom: 16,
              width: 160,
              height: 100,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 2),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10)],
                ),
                child: _buildRemoteVideo(stageIds[1]),
              ),
            ),
        ],
      );
    }

    return _buildRemoteVideo(stageIds.first);
  }

  Widget _buildRemoteVideo(String deviceId) {
    if (_controller.remoteRenderers.containsKey(deviceId)) {
      return RTCVideoView(
        _controller.remoteRenderers[deviceId]!,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      );
    }
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.videocam_off, color: Colors.white24),
            const SizedBox(height: 4),
            Text(deviceId, style: const TextStyle(color: Colors.white24, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartbeatHud() {
    final devId = _selectedDeviceId ??
        (_controller.activeDevices.isNotEmpty
            ? _controller.activeDevices.keys.first
            : null);
    final heartbeat = devId != null ? _controller.activeDevices[devId] : null;

    if (heartbeat == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.speed,
            color: Colors.greenAccent,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            '${heartbeat.deviceId} | ${heartbeat.resolution} | ${heartbeat.fps.toInt()} FPS',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          if (heartbeat.audioLevel != null) ...[
            const SizedBox(width: 8),
            const Icon(
              Icons.equalizer,
              color: Colors.amberAccent,
              size: 14,
            ),
            const SizedBox(width: 4),
            _buildAudioVuMeter(heartbeat.audioLevel!),
          ],
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFloatingCommentsPanel(),
          const SizedBox(height: 16),
          _buildBrandingPanel(),
          const SizedBox(height: 16),
          _buildBannersPanel(),
          const SizedBox(height: 16),
          _buildRtmpOutputPanel(),
          const SizedBox(height: 16),
          _buildSceneSwitcherCard(),
          const SizedBox(height: 16),
          _buildTeleprompterCueCard(),
          const SizedBox(height: 16),
          _buildStreamMetadataCard(),
          const SizedBox(height: 16),
          _buildQuickStyleTemplates(),
          const SizedBox(height: 16),
          _buildLowerThirdEditor(),
          const SizedBox(height: 16),
          _buildCameraControlBar(),
          const SizedBox(height: 16),
          _buildPresetManager(),
        ],
      ),
    );
  }

  Widget _buildRtmpOutputPanel() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.cast_connected, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Broadcast Outputs (RTMP)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Output'),
                  onPressed: _showAddRtmpDialog,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_rtmpDestinations.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No RTMP destinations configured.',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _rtmpDestinations.length,
                itemBuilder: (context, index) {
                  final dest = _rtmpDestinations[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: Icon(
                      Icons.settings_input_component,
                      color: dest.enabled ? Colors.green : Colors.white24,
                      size: 20,
                    ),
                    title: Text(
                      dest.platformName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      dest.url,
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: dest.enabled,
                          onChanged: (val) async {
                            final updated = dest.copyWith(enabled: val);
                            await _controller.saveRtmpDestination(updated);
                            await _loadRtmpDestinations();
                          },
                          activeThumbColor: Colors.orange,
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.green),
                          onPressed: () => _controller.sendBroadcastCommand(
                            command: 'start',
                            destinationId: dest.id,
                          ),
                          tooltip: 'Start Stream',
                        ),
                        IconButton(
                          icon: const Icon(Icons.stop, color: Colors.red),
                          onPressed: () => _controller.sendBroadcastCommand(
                            command: 'stop',
                            destinationId: dest.id,
                          ),
                          tooltip: 'Stop Stream',
                        ),
                        if (dest.id != null)
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white24),
                            onPressed: () async {
                              await _controller.deleteRtmpDestination(dest.id!);
                              await _loadRtmpDestinations();
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showAddRtmpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1e1e1e),
        title: const Text('Add RTMP Destination'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _rtmpPlatform,
                dropdownColor: const Color(0xff2a2a2a),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Platform'),
                items: ['YouTube', 'Twitch', 'Facebook', 'Discord', 'Custom']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _rtmpPlatform = val!),
              ),
              TextField(
                controller: _rtmpUrlController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'RTMP Server URL',
                  hintText: 'rtmp://a.rtmp.youtube.com/live2',
                ),
              ),
              TextField(
                controller: _rtmpKeyController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Stream Key',
                  hintText: 'xxxx-xxxx-xxxx-xxxx',
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final dest = RtmpDestination(
                streamId: widget.streamId,
                platformName: _rtmpPlatform,
                url: _rtmpUrlController.text,
                streamKey: _rtmpKeyController.text,
                enabled: true,
              );
              await _controller.saveRtmpDestination(dest);
              await _loadRtmpDestinations();
              if (!context.mounted) return;
              Navigator.pop(context);
              _rtmpUrlController.clear();
              _rtmpKeyController.clear();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildSceneSwitcherCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.video_library, color: Colors.redAccent, size: 20),
                SizedBox(width: 8),
                Text(
                  'Stage Layouts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildLayoutButton('solo', 'Solo', Icons.person),
                const SizedBox(width: 8),
                _buildLayoutButton('grid', 'Grid', Icons.grid_4x4),
                const SizedBox(width: 8),
                _buildLayoutButton('pip', 'PiP', Icons.picture_in_picture),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.layers, color: Colors.redAccent, size: 20),
                SizedBox(width: 8),
                Text(
                  'Scene Slates',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildSceneButton('camera', 'Camera', Icons.camera_alt),
                const SizedBox(width: 8),
                _buildSceneButton('color_bars', 'Bars', Icons.grid_view),
                const SizedBox(width: 8),
                _buildSceneButton('black_slate', 'Black', Icons.block),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutButton(String layoutKey, String label, IconData icon) {
    final isActive = _controller.layout == layoutKey;
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.blue : const Color(0xff2a2a2a),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => _setLayout(layoutKey),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSceneButton(String sceneKey, String label, IconData icon) {
    final isActive = _activeScene == sceneKey;
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.red : const Color(0xff2a2a2a),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isActive ? Colors.redAccent : Colors.transparent,
            ),
          ),
        ),
        onPressed: () => _switchScene(sceneKey),
        icon: Icon(icon, size: 16),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTeleprompterCueCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.record_voice_over, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Text(
                  'Teleprompter Cues & Director Chat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatInputController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type cue e.g. "Wrap up in 30s" or chat...',
                      hintStyle: TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Color(0xff2a2a2a),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendProducerChat(isCue: true),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[700],
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () => _sendProducerChat(isCue: true),
                  child: const Text(
                    'Cue',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white70),
                  onPressed: () => _sendProducerChat(isCue: false),
                  tooltip: 'Send Chat Message',
                ),
              ],
            ),
            if (_chatMessages.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xff141414),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, i) {
                    final msg = _chatMessages[i];
                    final isCue = msg.isDirectorCue == true;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '${msg.senderName}: ${msg.message}',
                        style: TextStyle(
                          color: isCue ? Colors.amberAccent : Colors.white70,
                          fontSize: 12,
                          fontWeight: isCue
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCommentsPanel() {
    final featuredComment = _controller.activeFeaturedComment;

    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.comment, color: Colors.cyanAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Floating Comments',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                if (featuredComment != null && featuredComment.isVisible)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onPressed: _takeDownFeaturedComment,
                    child:
                        const Text('TAKE DOWN', style: TextStyle(fontSize: 10)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xff141414),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _chatMessages.isEmpty
                  ? const Center(
                      child: Text(
                        'No incoming comments yet...',
                        style: TextStyle(color: Colors.white24, fontSize: 12),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _chatMessages.length,
                      itemBuilder: (context, i) {
                        final msg = _chatMessages[_chatMessages.length - 1 - i];
                        final isFeatured = featuredComment != null &&
                            featuredComment.isVisible &&
                            featuredComment.message == msg.message &&
                            featuredComment.senderName == msg.senderName;

                        return Card(
                          color: isFeatured
                              ? Colors.cyan.withValues(alpha: 0.2)
                              : const Color(0xff1e1e1e),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: msg.avatarUrl != null
                                  ? NetworkImage(msg.avatarUrl!)
                                  : null,
                              radius: 16,
                              child: msg.avatarUrl == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            title: Text(
                              msg.senderName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              msg.message,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            trailing: Icon(
                              _getPlatformIcon(msg.platform),
                              size: 16,
                              color: Colors.white38,
                            ),
                            onTap: () => _featureComment(msg),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getPlatformIcon(String? platform) {
    switch (platform?.toLowerCase()) {
      case 'youtube':
        return Icons.play_circle_filled;
      case 'twitch':
        return Icons.videogame_asset;
      case 'facebook':
        return Icons.facebook;
      default:
        return Icons.message;
    }
  }

  Widget _buildStreamMetadataCard() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Stream Metadata & Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      _controller.isBroadcasting ? 'ON AIR' : 'OFF AIR',
                      style: TextStyle(
                        color: _controller.isBroadcasting ? Colors.red : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Switch(
                      value: _isBroadcastingLive,
                      activeThumbColor: Colors.red,
                      onChanged: (val) async {
                        setState(() => _isBroadcastingLive = val);
                        await _controller.saveMetadata(
                          title: _streamTitleController.text,
                          description: _streamDescController.text,
                          isLive: val,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _streamTitleController,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'Broadcast Title',
                labelStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _streamDescController,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(Icons.save, size: 16),
                label: const Text('Save Metadata to DB'),
                onPressed: () async {
                  await _controller.saveMetadata(
                    title: _streamTitleController.text,
                    description: _streamDescController.text,
                    isLive: _isBroadcastingLive,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Metadata saved!')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStyleTemplates() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Graphic Styles',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionChip(
                  label: const Text('🔴 Breaking News'),
                  backgroundColor: const Color(0xffE50914),
                  onPressed: () => _applyQuickTemplate(
                    'BREAKING NEWS',
                    'Key developer update live from StreamStudio',
                    'lower_third',
                    '#E50914',
                    'slide',
                  ),
                ),
                ActionChip(
                  label: const Text('🎙️ Guest Speaker'),
                  backgroundColor: const Color(0xff1E88E5),
                  onPressed: () => _applyQuickTemplate(
                    'Sarah Connor',
                    'Lead Architect • Cyberdyne Systems',
                    'lower_third',
                    '#1E88E5',
                    'fade',
                  ),
                ),
                ActionChip(
                  label: const Text('📊 Live Ticker'),
                  backgroundColor: const Color(0xff00897B),
                  onPressed: () => _applyQuickTemplate(
                    'MARKETS UPDATE',
                    'Serverpod 4.0 releases worldwide • Streaming engine at full capacity',
                    'ticker',
                    '#00897B',
                    'fade',
                  ),
                ),
                ActionChip(
                  label: const Text('🏷️ Top Corner Badge'),
                  backgroundColor: const Color(0xff5E35B1),
                  onPressed: () => _applyQuickTemplate(
                    'EXCLUSIVE INTERVIEW',
                    '',
                    'top_right',
                    '#5E35B1',
                    'scale',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLowerThirdEditor() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.subtitles, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Live Graphics Overlay Editor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOverlayVisible
                        ? Colors.grey[700]
                        : Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _pushOverlayLive(!_isOverlayVisible),
                  child: Text(
                    _isOverlayVisible ? 'TAKE DOWN' : 'PUSH LIVE',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Title / Speaker Name',
                labelStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _subtitleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Subtitle / Description',
                labelStyle: TextStyle(color: Colors.white60),
                filled: true,
                fillColor: Color(0xff2a2a2a),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedPosition,
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Position',
                      labelStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Color(0xff2a2a2a),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'lower_third',
                        child: Text('Lower Third'),
                      ),
                      DropdownMenuItem(
                        value: 'top_right',
                        child: Text('Top Right Corner'),
                      ),
                      DropdownMenuItem(
                        value: 'ticker',
                        child: Text('Bottom Ticker'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedPosition = val);
                        if (_isOverlayVisible) _pushOverlayLive(true);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedAnimationStyle,
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Animation',
                      labelStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Color(0xff2a2a2a),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'fade', child: Text('Fade In')),
                      DropdownMenuItem(value: 'slide', child: Text('Slide Up')),
                      DropdownMenuItem(
                        value: 'scale',
                        child: Text('Scale Zoom'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedAnimationStyle = val);
                        if (_isOverlayVisible) _pushOverlayLive(true);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraControlBar() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.settings_remote,
                  color: Colors.greenAccent,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Remote Camera Hardware Controls',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Zoom: ', style: TextStyle(color: Colors.white70)),
                Expanded(
                  child: Slider(
                    value: _zoomLevel,
                    min: 1.0,
                    max: 5.0,
                    divisions: 8,
                    label: '${_zoomLevel.toStringAsFixed(1)}x',
                    activeColor: Colors.red,
                    onChanged: (val) {
                      setState(() => _zoomLevel = val);
                      _updateCameraControl();
                    },
                  ),
                ),
                Text(
                  '${_zoomLevel.toStringAsFixed(1)}x',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _torchOn
                        ? Colors.amber[800]
                        : const Color(0xff2a2a2a),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _torchOn = !_torchOn);
                    _updateCameraControl();
                  },
                  icon: Icon(_torchOn ? Icons.flash_on : Icons.flash_off),
                  label: Text(_torchOn ? 'Torch ON' : 'Torch OFF'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2a2a2a),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(
                      () =>
                          _activeCameraIndex = _activeCameraIndex == 0 ? 1 : 0,
                    );
                    _updateCameraControl();
                  },
                  icon: const Icon(Icons.flip_camera_ios),
                  label: Text(
                    _activeCameraIndex == 0 ? 'Back Cam' : 'Front Cam',
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isAudioMuted
                        ? Colors.red[800]
                        : const Color(0xff2a2a2a),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => _isAudioMuted = !_isAudioMuted);
                    _updateCameraControl();
                  },
                  icon: Icon(_isAudioMuted ? Icons.mic_off : Icons.mic),
                  label: Text(_isAudioMuted ? 'Muted' : 'Mute Mic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetManager() {
    return Card(
      color: const Color(0xff1e1e1e),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bookmarks, color: Colors.purpleAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Overlay Presets (PostgreSQL)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Save Preset'),
                  onPressed: () async {
                    final preset = OverlayPreset(
                      streamId: widget.streamId,
                      title: _titleController.text,
                      subtitle: _subtitleController.text,
                      position: _selectedPosition,
                      backgroundColor: _backgroundColorHex,
                      textColor: _textColorHex,
                    );
                    await _controller.savePreset(preset);
                    await _loadPresets();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_presets.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'No saved presets yet for this stream.',
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _presets.length,
                itemBuilder: (context, index) {
                  final p = _presets[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      p.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${p.position} • ${p.subtitle}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _titleController.text = p.title;
                              _subtitleController.text = p.subtitle;
                              _selectedPosition = p.position;
                              _backgroundColorHex = p.backgroundColor;
                              _textColorHex = p.textColor;
                            });
                            _pushOverlayLive(true);
                          },
                          tooltip: 'Apply Preset',
                        ),
                        if (p.id != null)
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white38,
                            ),
                            onPressed: () async {
                              await _controller.deletePreset(p.id!);
                              await _loadPresets();
                            },
                            tooltip: 'Delete Preset',
                          ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamTitleController.dispose();
    _streamDescController.dispose();
    _chatInputController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _messageSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
