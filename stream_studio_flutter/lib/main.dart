import 'package:flutter/material.dart';
import 'client.dart';
import 'views/camera_studio_view.dart';
import 'views/companion_studio_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const StreamStudioApp());
}

class StreamStudioApp extends StatelessWidget {
  const StreamStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamStudio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff121212),
        primaryColor: Colors.red,
        colorScheme: const ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.redAccent,
        ),
      ),
      home: const ModeSelectorScreen(),
    );
  }
}

class ModeSelectorScreen extends StatefulWidget {
  const ModeSelectorScreen({super.key});

  @override
  State<ModeSelectorScreen> createState() => _ModeSelectorScreenState();
}

class _ModeSelectorScreenState extends State<ModeSelectorScreen> {
  final _streamIdController = TextEditingController(text: 'studio_room_1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.live_tv, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'StreamStudio',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Real-time Live Studio Production Engine (Serverpod 4)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 36),
                TextField(
                  controller: _streamIdController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Stream Room ID',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.numbers, color: Colors.red),
                    filled: true,
                    fillColor: Color(0xff1e1e1e),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final streamId = _streamIdController.text.trim();
                    if (streamId.isEmpty) return;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CameraStudioView(
                          client: client,
                          streamId: streamId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text(
                    'Launch Mobile Camera Source',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final streamId = _streamIdController.text.trim();
                    if (streamId.isEmpty) return;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CompanionStudioView(
                          client: client,
                          streamId: streamId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.dashboard, color: Colors.red),
                  label: const Text(
                    'Launch Companion Web Studio',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamIdController.dispose();
    super.dispose();
  }
}
