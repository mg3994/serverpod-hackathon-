import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Real-time WebSocket endpoint that acts as a message bus for studio rooms.
///
/// Both the mobile camera source and the companion web studio connect here.
/// Every message sent by any client on [inbound] is broadcast to all other
/// clients subscribed to the same studio room channel.
///
/// The [streamId] query parameter identifies the room to join.
class StudioEndpoint extends Endpoint {
  static const String _channelPrefix = 'studio_room_';

  /// Bidirectional stream method for the studio room.
  ///
  /// Clients send studio messages (e.g., [StudioMessage]) via [inbound]
  /// and receive messages from all other clients via the returned output stream.
  Stream<StudioMessage> stream(
    Session session,
    Stream<StudioMessage> inbound,
    String streamId,
  ) async* {
    final channel = '$_channelPrefix$streamId';
    final controller = StreamController<StudioMessage>.broadcast();

    // Send welcome message immediately.
    final welcome = StudioMessage(
      streamId: streamId,
      type: 'chat',
      chatMessage: StudioChatMessage(
        streamId: streamId,
        senderName: 'System',
        message: 'Connected to studio room: $streamId',
        timestamp: DateTime.now().toUtc(),
        isDirectorCue: false,
      ),
    );
    controller.add(welcome);

    // Register listener on the message central to receive broadcast messages.
    void onMessage(SerializableModel msg) {
      if (msg is StudioMessage && !controller.isClosed) {
        controller.add(msg);
      }
    }

    session.messages.addListener(channel, onMessage);

    // Forward inbound client messages to the broadcast channel.
    final subscription = inbound.listen(
      (msg) async {
        await session.messages.postMessage(channel, msg);
      },
      onDone: controller.close,
      onError: (_) => controller.close(),
      cancelOnError: true,
    );

    try {
      yield* controller.stream;
    } finally {
      session.messages.removeListener(channel, onMessage);
      await subscription.cancel();
      await controller.close();
    }
  }
}
