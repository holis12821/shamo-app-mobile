import 'dart:math';

class IdGenerator {
  static String generateUserId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(99999);
    return 'user_${timestamp}_$random';
  }
}
