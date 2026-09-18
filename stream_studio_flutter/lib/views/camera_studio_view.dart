import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stream_studio_client/stream_studio_client.dart';
import '../controllers/studio_controller.dart';

class CameraStudioView extends StatefulWidget {
  final Client client;
  final String streamId;

  const CameraStudioView({
    super.key,
    required this.client,
    required this.streamId,
  });

  @override
  State<CameraStudioView> createState() => _CameraStudioViewState();
}

class _CameraStudioViewState extends State<CameraStudioView>
    with SingleTickerProviderStateMixin {
  late StudioController _controller;
  StreamSubscription<StudioMessage>? _messageSubscription;

  OverlayConfig? _activeOverlay;
  String _activeScene = 'camera'; // "camera", "color_bars", "black_slate"
  String? _directorCueMessage;
  bool _isConnected = false;
  double _currentZoom = 1.0;
  bool _isTorchOn = false;
  bool _isAudioMuted = false;
  int _activeCameraIndex = 0; // 0 = Back, 1 = Front
  Timer? _heartbeatTimer;
  Timer? _cueTimer;
  final String _deviceId =
      'cam_${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
  final Random _random = Random();

  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _controller = StudioController(
      client: widget.client,
      streamId: widget.streamId,
    );

    _setupStudioCamera();
  }

  void _setupStudioCamera() {
    _controller.connect();

    _messageSubscription = _controller.messages.listen((msg) {
      if (!mounted) return;

      setState(() {
        _isConnected = true;
      });

      if (msg.overlayConfig != null) {
        setState(() => _activeOverlay = msg.overlayConfig);
      } else if (msg.cameraControl != null) {
        _applyHardwareControls(msg.cameraControl!);
      } else if (msg.sceneControl != null) {
        setState(() => _activeScene = msg.sceneControl!.activeScene);
      } else if (msg.chatMessage != null) {
        if (msg.chatMessage!.isDirectorCue == true) {
          _showDirectorCue(msg.chatMessage!.message);
        }
      }
    });

    _startHeartbeatTimer();
  }

  void _showDirectorCue(String cueText) {
    _cueTimer?.cancel();
    setState(() => _directorCueMessage = cueText);
    _cueTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() => _directorCueMessage = null);
      }
    });
  }

  void _startHeartbeatTimer() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      final double simulatedAudioLevel = _isAudioMuted
          ? 0.0
          : (0.35 + _random.nextDouble() * 0.55);

      _controller.sendHeartbeat(
        StreamHeartbeat(
          streamId: widget.streamId,
          deviceId: _deviceId,
          deviceType: 'mobile_camera',
          fps: 30.0,
          resolution: '1920x1080',
          audioLevel: simulatedAudioLevel,
          timestamp: DateTime.now().toUtc(),
        ),
      );
    });
  }

  void _applyHardwareControls(CameraControl control) {
    setState(() {
      _currentZoom = control.zoomLevel;
      _isTorchOn = control.torchOn;
      _activeCameraIndex = control.activeCameraIndex;
      if (control.isMuted != null) {
        _isAudioMuted = control.isMuted!;
      }
    });
  }

  void _toggleTorch() {
    setState(() => _isTorchOn = !_isTorchOn);
    _controller.updateCameraHardware(
      zoomLevel: _currentZoom,
      torchOn: _isTorchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _flipCamera() {
    setState(() => _activeCameraIndex = _activeCameraIndex == 0 ? 1 : 0);
    _controller.updateCameraHardware(
      zoomLevel: _currentZoom,
      torchOn: _isTorchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _toggleMute() {
    setState(() => _isAudioMuted = !_isAudioMuted);
    _controller.updateCameraHardware(
      zoomLevel: _currentZoom,
      torchOn: _isTorchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
    );
  }

  void _adjustZoom(double newZoom) {
    setState(() => _currentZoom = newZoom.clamp(1.0, 5.0));
    _controller.updateCameraHardware(
      zoomLevel: _currentZoom,
      torchOn: _isTorchOn,
      activeCameraIndex: _activeCameraIndex,
      isMuted: _isAudioMuted,
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

  Widget _buildSceneBackground() {
    if (_activeScene == 'black_slate') {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const Text(
          '● BLACK SLATE ACTIVE',
          style: TextStyle(
            color: Colors.white24,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (_activeScene == 'color_bars') {
      return Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(child: Container(color: const Color(0xffc0c0c0))),
                  Expanded(child: Container(color: const Color(0xffc0c000))),
                  Expanded(child: Container(color: const Color(0xff00c0c0))),
                  Expanded(child: Container(color: const Color(0xff00c000))),
                  Expanded(child: Container(color: const Color(0xffc000c0))),
                  Expanded(child: Container(color: const Color(0xffc00000))),
                  Expanded(child: Container(color: const Color(0xff0000c0))),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Default Camera Feed Viewfinder
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [
            _isTorchOn ? const Color(0xff3a3a2a) : const Color(0xff1a1e24),
            const Color(0xff0a0c10),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Optical Rule of Thirds Grid
          CustomPaint(
            size: Size.infinite,
            painter: _ViewfinderGridPainter(),
          ),

          // Central Animated Reticle
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final scale = 1.0 + (_pulseController.value * 0.05);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isTorchOn
                          ? Colors.amber.withValues(alpha: 0.6)
                          : Colors.white.withValues(alpha: 0.25),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _isTorchOn ? Colors.amber : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Camera Lens Info Overlay
          Positioned(
            bottom: 120,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _activeCameraIndex == 0
                        ? Icons.camera_rear
                        : Icons.camera_front,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _activeCameraIndex == 0
                        ? 'BACK 4K (f/1.8)'
                        : 'FRONT (f/2.2)',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_currentZoom.toStringAsFixed(1)}X ZOOM',
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayContent(OverlayConfig overlay) {
    final bgColor = _parseColor(
      overlay.backgroundColor,
      const Color(0xffe50914),
    );
    final textColor = _parseColor(overlay.textColor, Colors.white);

    if (overlay.position == 'top_right') {
      return Container(
        key: ValueKey('tr_${overlay.id}'),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, color: Colors.white, size: 8),
            const SizedBox(width: 8),
            Text(
              overlay.title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (overlay.position == 'ticker') {
      return Container(
        key: ValueKey('ticker_${overlay.id}'),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: bgColor.withValues(alpha: 0.95),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black,
              child: Text(
                overlay.title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                overlay.subtitle,
                style: TextStyle(color: textColor, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    // Default Lower Third
    return Container(
      key: ValueKey('lt_${overlay.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            overlay.title,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (overlay.subtitle.isNotEmpty)
            Text(
              overlay.subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedOverlay(OverlayConfig overlay) {
    final style = overlay.animationStyle ?? 'fade';

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        if (style == 'slide') {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        } else if (style == 'scale') {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        }
        return FadeTransition(opacity: animation, child: child);
      },
      child: _buildOverlayContent(overlay),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Layer: Active Scene (Camera Feed vs Color Bars Slate vs Black Slate)
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildSceneBackground(),
            ),
          ),

          // Live Connection Status Badge
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isConnected ? Colors.green : Colors.red,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: _isConnected ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isConnected ? 'LIVE (ID: $_deviceId)' : 'CONNECTING...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isAudioMuted) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.mic_off,
                      color: Colors.redAccent,
                      size: 14,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Back / Leave button
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
              ),
            ),
          ),

          // Teleprompter / Director Cue Banner
          if (_directorCueMessage != null)
            Positioned(
              top: 85,
              left: 20,
              right: 20,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [
                      BoxShadow(color: Colors.black54, blurRadius: 10),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.record_voice_over,
                        color: Colors.black,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _directorCueMessage!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Top Layer: Live Overlay Canvas Stack
          if (_activeOverlay != null && _activeOverlay!.isVisible)
            Positioned.fill(
              child: Align(
                alignment: _activeOverlay!.position == 'top_right'
                    ? Alignment.topRight
                    : _activeOverlay!.position == 'ticker'
                    ? Alignment.bottomCenter
                    : Alignment.bottomLeft,
                child: Padding(
                  padding: _activeOverlay!.position == 'ticker'
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(24.0),
                  child: _buildAnimatedOverlay(_activeOverlay!),
                ),
              ),
            ),

          // Camera Operator Action Bar (Bottom)
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      _isTorchOn ? Icons.flash_on : Icons.flash_off,
                      color: _isTorchOn ? Colors.amber : Colors.white70,
                    ),
                    onPressed: _toggleTorch,
                    tooltip: 'Toggle Torch',
                  ),
                  IconButton(
                    icon: Icon(
                      _isAudioMuted ? Icons.mic_off : Icons.mic,
                      color: _isAudioMuted ? Colors.redAccent : Colors.white70,
                    ),
                    onPressed: _toggleMute,
                    tooltip: 'Toggle Mic Mute',
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white70,
                    ),
                    onPressed: _flipCamera,
                    tooltip: 'Flip Camera',
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.zoom_out, color: Colors.white70),
                        onPressed: () => _adjustZoom(_currentZoom - 0.5),
                      ),
                      Text(
                        '${_currentZoom.toStringAsFixed(1)}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_in, color: Colors.white70),
                        onPressed: () => _adjustZoom(_currentZoom + 0.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _heartbeatTimer?.cancel();
    _cueTimer?.cancel();
    _messageSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }
}

class _ViewfinderGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1.0;

    final x1 = size.width / 3;
    final x2 = size.width * 2 / 3;
    final y1 = size.height / 3;
    final y2 = size.height * 2 / 3;

    canvas.drawLine(Offset(x1, 0), Offset(x1, size.height), paint);
    canvas.drawLine(Offset(x2, 0), Offset(x2, size.height), paint);
    canvas.drawLine(Offset(0, y1), Offset(size.width, y1), paint);
    canvas.drawLine(Offset(0, y2), Offset(size.width, y2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
