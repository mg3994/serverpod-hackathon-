import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StreamMetadataEndpoint extends Endpoint {
  static final Map<String, StreamMetadata> _inMemoryMetadata = {};

  /// Save or update stream metadata
  Future<StreamMetadata> saveMetadata(
    Session session,
    StreamMetadata metadata,
  ) async {
    try {
      if (metadata.id != null) {
        return await StreamMetadata.db.updateRow(session, metadata);
      } else {
        final existing = await StreamMetadata.db.findFirstRow(
          session,
          where: (t) => t.streamId.equals(metadata.streamId),
        );
        if (existing != null) {
          final updated = existing.copyWith(
            title: metadata.title,
            description: metadata.description,
            isLive: metadata.isLive,
            viewerCount: metadata.viewerCount,
            startedAt: metadata.startedAt,
          );
          return await StreamMetadata.db.updateRow(session, updated);
        }
        return await StreamMetadata.db.insertRow(session, metadata);
      }
    } catch (_) {
      _inMemoryMetadata[metadata.streamId] = metadata;
      return metadata;
    }
  }

  /// Get metadata for a specific streamId
  Future<StreamMetadata?> getMetadata(
    Session session,
    String streamId,
  ) async {
    try {
      return await StreamMetadata.db.findFirstRow(
        session,
        where: (t) => t.streamId.equals(streamId),
      );
    } catch (_) {
      return _inMemoryMetadata[streamId];
    }
  }
}
