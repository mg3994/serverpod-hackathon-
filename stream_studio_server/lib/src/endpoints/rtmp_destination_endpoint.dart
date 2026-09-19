import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class RtmpDestinationEndpoint extends Endpoint {
  static final List<RtmpDestination> _inMemoryDestinations = [];

  /// Save a new RTMP destination or update if existing ID provided
  Future<RtmpDestination> saveDestination(
    Session session,
    RtmpDestination destination,
  ) async {
    try {
      if (destination.id != null) {
        return await RtmpDestination.db.updateRow(session, destination);
      } else {
        return await RtmpDestination.db.insertRow(session, destination);
      }
    } catch (_) {
      // Fallback in case PostgreSQL is not running in dev
      if (destination.id != null) {
        final idx = _inMemoryDestinations.indexWhere((d) => d.id == destination.id);
        if (idx != -1) {
          _inMemoryDestinations[idx] = destination;
          return destination;
        }
      }
      final newDest = destination.copyWith(id: _inMemoryDestinations.length + 1);
      _inMemoryDestinations.add(newDest);
      return newDest;
    }
  }

  /// List all RTMP destinations for a specific streamId
  Future<List<RtmpDestination>> listDestinations(
    Session session,
    String streamId,
  ) async {
    try {
      return await RtmpDestination.db.find(
        session,
        where: (t) => t.streamId.equals(streamId),
      );
    } catch (_) {
      return _inMemoryDestinations.where((d) => d.streamId == streamId).toList();
    }
  }

  /// Delete an RTMP destination by ID
  Future<bool> deleteDestination(
    Session session,
    int id,
  ) async {
    try {
      final deleted = await RtmpDestination.db.deleteWhere(
        session,
        where: (t) => t.id.equals(id),
      );
      return deleted.isNotEmpty;
    } catch (_) {
      final before = _inMemoryDestinations.length;
      _inMemoryDestinations.removeWhere((d) => d.id == id);
      return _inMemoryDestinations.length < before;
    }
  }
}
