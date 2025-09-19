import 'package:equatable/equatable.dart';
import 'package:shamoapps/domain/entity/chat.dart';

class ChatState extends Equatable {
  final List<Chat> chatList;
  final bool isTyping;
  final bool isPlayReplySound;
  final bool isShowProductPreview;

  const ChatState({
    required this.chatList,
    required this.isTyping,
    this.isPlayReplySound = false,
    this.isShowProductPreview = false,
  });

  // Factory initial state
  factory ChatState.initial() => const ChatState(
        chatList: [],
        isTyping: false,
        isPlayReplySound: false,
        isShowProductPreview: false,
      );

  ChatState copyWith({
    List<Chat>? chatList,
    bool? isTyping,
    bool? isPlayReplySound,
    bool? isShowProductPreview,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      isTyping: isTyping ?? this.isTyping,
      isPlayReplySound: isPlayReplySound ?? this.isPlayReplySound,
      isShowProductPreview: isShowProductPreview ?? this.isShowProductPreview,
    );
  }

  @override
  List<Object?> get props => [
        chatList,
        isTyping,
        isPlayReplySound,
        isShowProductPreview,
      ];
}
