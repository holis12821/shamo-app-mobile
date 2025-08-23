import 'package:equatable/equatable.dart';

sealed class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadInitialMessages extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String text;
  SendMessage(this.text);

  @override
  List<Object?> get props => [text];
}

class ReplyMessage extends ChatEvent {}

// called when the user scrolls up to load an old message
class HistoryRequested extends ChatEvent {}

class ProductPreview extends ChatEvent {
  final bool isVisible;
  ProductPreview(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class ResetReplySound extends ChatEvent {}

