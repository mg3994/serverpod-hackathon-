# Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `stream_studio_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `stream_studio_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.

## Stream Studio Architecture

Stream Studio is a real-time live video production suite built with Serverpod 4.0:

### Server Architecture (`stream_studio_server`)
- **WebSocket Streaming Bus (`StudioEndpoint`):** Uses Serverpod 4's bidirectional streaming endpoint method `Stream<StudioMessage> stream(Session, Stream<StudioMessage>, String streamId)`. Clients join named studio rooms (`studio_room_{streamId}`) via message central pub/sub.
- **REST Endpoints:**
  - `OverlayPresetEndpoint`: CRUD operations on `OverlayPreset` in PostgreSQL (`savePreset`, `listPresets`, `deletePreset`).
  - `StreamMetadataEndpoint`: Persistence and upsert for `StreamMetadata` (`saveMetadata`, `getMetadata`).
- **Models (`.spy.yaml`):**
  - `StudioMessage`: Typed polymorphic wrapper for real-time WebSocket communication.
  - `CameraControl`: Remote hardware control (torch, zoom, active camera index, mute).
  - `SceneControl`: Instant scene switching (camera, color_bars, black_slate).
  - `OverlayConfig`: Live broadcast graphics overlay (title, subtitle, position, colors, animation).
  - `SignalingMessage`: WebRTC peer connection signaling (offer, answer, ICE candidates).
  - `StreamHeartbeat`: Telemetry from camera (FPS, resolution, audio VU levels, device ID).
  - `StudioChatMessage`: Director cues and operator chat.
  - `OverlayPreset` (DB Table `overlay_preset`): Persisted overlay presets.
  - `StreamMetadata` (DB Table `stream_metadata`): Live broadcast title, description, isLive status.

### Flutter App (`stream_studio_flutter`)
- **Mode Selector Screen (`main.dart`):** Lets user enter a Stream Room ID and launch either mode.
- **Mobile Camera Source (`views/camera_studio_view.dart`):** Viewfinder with optical rule-of-thirds grid, animated reticle, live connection badge, teleprompter director cue bar, animated lower third overlay canvas, hardware controls (torch, flip, mute, zoom), and 3-second heartbeat telemetry.
- **Companion Web Studio (`views/companion_studio_view.dart`):** Director dashboard with Program Monitor (On-Air / Standby tally, audio VU meter, device telemetry), Scene Switcher (Camera, SMPTE Color Bars, Black Slate), Teleprompter & Chat panel, Stream Metadata editor, Quick Graphic Style templates, Lower-Third Live Editor, Remote Camera Hardware control bar, and PostgreSQL Overlay Preset Manager.
- **Studio Controller (`controllers/studio_controller.dart`):** Encapsulates the Serverpod 4 WebSocket stream connection and REST endpoints into a clean `ChangeNotifier`.
