import 'package:audioplayers/audioplayers.dart';

class SoundHelper {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSendSound() async {
    await _player.play(AssetSource('sounds/incoming_message.mp3'));
  }

  static void dispose() {
    _player.dispose();
  }
}