import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class OverlayPresetEndpoint extends Endpoint {
  static final List<OverlayPreset> _inMemoryPresets = [];

  /// Save a new overlay preset or update if existing ID provided
  Future<OverlayPreset> savePreset(
    Session session,
    OverlayPreset preset,
  ) async {
    try {
      if (preset.id != null) {
        return await OverlayPreset.db.updateRow(session, preset);
      } else {
        return await OverlayPreset.db.insertRow(session, preset);
      }
    } catch (_) {
      // Fallback in case PostgreSQL is not running in dev
      if (preset.id != null) {
        final idx = _inMemoryPresets.indexWhere((p) => p.id == preset.id);
        if (idx != -1) {
          _inMemoryPresets[idx] = preset;
          return preset;
        }
      }
      final newPreset = preset.copyWith(id: _inMemoryPresets.length + 1);
      _inMemoryPresets.add(newPreset);
      return newPreset;
    }
  }

  /// List all overlay presets for a specific streamId
  Future<List<OverlayPreset>> listPresets(
    Session session,
    String streamId,
  ) async {
    try {
      return await OverlayPreset.db.find(
        session,
        where: (t) => t.streamId.equals(streamId),
      );
    } catch (_) {
      return _inMemoryPresets.where((p) => p.streamId == streamId).toList();
    }
  }

  /// Delete an overlay preset by ID
  Future<bool> deletePreset(Session session, int id) async {
    try {
      final deleted = await OverlayPreset.db.deleteWhere(
        session,
        where: (t) => t.id.equals(id),
      );
      return deleted.isNotEmpty;
    } catch (_) {
      final before = _inMemoryPresets.length;
      _inMemoryPresets.removeWhere((p) => p.id == id);
      return _inMemoryPresets.length < before;
    }
  }
}
