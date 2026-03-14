import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_provider.g.dart';

/// Service for playing system alarm/notification/ringtone sounds.
class AudioService {
  const AudioService();

  /// Play a system sound by type ID.
  Future<void> play(String soundId) async {
    switch (soundId) {
      case 'alarm':
        await FlutterRingtonePlayer().playAlarm(looping: false);
      case 'ringtone':
        await FlutterRingtonePlayer().playRingtone(looping: false);
      case 'notification':
        await FlutterRingtonePlayer().playNotification();
      case _:
        await FlutterRingtonePlayer().playAlarm(looping: false);
    }
  }

  /// Stop any currently playing sound.
  Future<void> stop() async {
    await FlutterRingtonePlayer().stop();
  }
}

@Riverpod(keepAlive: true)
AudioService audioService(Ref ref) => const AudioService();
