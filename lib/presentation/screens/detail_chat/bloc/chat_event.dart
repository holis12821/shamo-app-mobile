sealed class ChatEvent {}

class LoadInitialMessages extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String text;
  SendMessage(this.text);
}

class ReplyMessage extends ChatEvent {}

// called when the user scrolls up to load an old message
class HistoryRequested extends ChatEvent {}

class ProductPreview extends ChatEvent {
  final bool isVisible;
  ProductPreview(this.isVisible);
}

class ResetReplySound extends ChatEvent {}

