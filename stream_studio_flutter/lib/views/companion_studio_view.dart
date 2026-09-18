import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stream_studio_client/stream_studio_client.dart';
import '../controllers/studio_controller.dart';

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
  StreamHeartbeat? _latestHeartbeat;

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

  @override
  void initState() {
    super.initState();
    _controller = StudioController(
      client: widget.client,
      streamId: widget.streamId,
    );
    _initStudio();
  }

  Future<void> _initStudio() async {
    _controller.connect();

    _messageSubscription = _controller.messages.listen((msg) {
      if (!mounted) return;

      setState(() => _isConnected = true);

      if (msg.heartbeat != null) {
        setState(() => _latestHeartbeat = msg.heartbeat);
      } else if (msg.sceneControl != null) {
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
      zoomLevel: _zoomLevel,
      torchOn: _torchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _switchScene(String scene) {
    setState(() => _activeScene = scene);
    _controller.sendSceneControl(activeScene: scene);
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
                  _isConnected ? 'LIVE STUDIO' : 'CONNECTING',
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildPreviewViewport()),
                    Expanded(flex: 2, child: _buildControlPanel()),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 380, child: _buildPreviewViewport()),
                      _buildControlPanel(),
                    ],
                  ),
                );
        },
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
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.2,
                        colors: [
                          _torchOn
                              ? const Color(0xff2a2a20)
                              : const Color(0xff181c22),
                          const Color(0xff0a0c10),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam,
                            size: 56,
                            color: _isBroadcastingLive
                                ? Colors.redAccent
                                : Colors.white38,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _isBroadcastingLive
                                ? 'PROGRAM VIDEO ON AIR'
                                : 'CAMERA SOURCE CONNECTED',
                            style: TextStyle(
                              color: _isBroadcastingLive
                                  ? Colors.redAccent
                                  : Colors.white54,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_zoomLevel.toStringAsFixed(1)}x Zoom • ${_activeCameraIndex == 0 ? "Back Lens" : "Front Lens"}${_torchOn ? " • Torch ON" : ""}',
                            style: const TextStyle(
                              color: Colors.white30,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),

          // Tally Indicator
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _isBroadcastingLive
                    ? 'ON AIR (${_activeScene.toUpperCase()})'
                    : 'STANDBY (${_activeScene.toUpperCase()})',
                style: TextStyle(
                  color: _isBroadcastingLive ? Colors.red : Colors.amber,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          if (_latestHeartbeat != null)
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
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
                      '${_latestHeartbeat!.deviceId} | ${_latestHeartbeat!.resolution} | ${_latestHeartbeat!.fps.toInt()} FPS',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (_latestHeartbeat!.audioLevel != null) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.equalizer,
                        color: Colors.amberAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      _buildAudioVuMeter(_latestHeartbeat!.audioLevel!),
                    ],
                  ],
                ),
              ),
            ),
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
                  'Scene Switcher',
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
                _buildSceneButton('camera', 'Camera 1', Icons.camera_alt),
                const SizedBox(width: 8),
                _buildSceneButton('color_bars', 'Color Bars', Icons.grid_view),
                const SizedBox(width: 8),
                _buildSceneButton('black_slate', 'Black Slate', Icons.block),
              ],
            ),
          ],
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
                      _isBroadcastingLive ? 'ON AIR' : 'STANDBY',
                      style: TextStyle(
                        color: _isBroadcastingLive ? Colors.red : Colors.grey,
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
