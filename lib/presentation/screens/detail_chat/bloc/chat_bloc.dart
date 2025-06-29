import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/domain/entity/chat.dart';
import 'package:shamoapps/domain/entity/product.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_event.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<LoadInitialMessages>(_onLoadInitialMessages);
    on<SendMessage>(_onSendMessage);
    on<ReplyMessage>(_onReplyChat);
    on<ProductPreview>(_isShowProductPreview);
    on<ResetReplySound>(_onResetReplySound);
  }

  Future<void> _onLoadInitialMessages(
    LoadInitialMessages event,
    Emitter<ChatState> emit,
  ) async {
    final newMessages = [
      Chat.product(
        Product(
          name: 'COURT VISION 2.0 SHOES',
          imageUrl: CustomAssets.kShoesImage,
          price: 1000000,
        ),
        SenderType.sender,
      ),
      Chat.message(
        "Hi, This item is still available?",
        SenderType.sender,
      ),
      Chat.message(
        "Only size 42 and 43 available.",
        SenderType.receiver,
      ),
    ];

    emit(state.copyWith(chatList: [...state.chatList, ...newMessages]));
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (event.text.trim().isEmpty) return;

    final userMessage = Chat.message(event.text.trim(), SenderType.sender);

    final updatedList = [...state.chatList, userMessage];
    emit(
      state.copyWith(
        chatList: updatedList,
        isShowProductPreview: false,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isTyping: true));
    await Future.delayed(const Duration(seconds: 1));
    add(ReplyMessage());
  }

  void _onReplyChat(ReplyMessage event, Emitter<ChatState> emit) {
    final replyMessage = Chat.message(
      "Thanks for your message. We'll respond shortly.",
      SenderType.receiver,
    );
    emit(
      state.copyWith(
        chatList: [...state.chatList, replyMessage],
        isTyping: false,
        isPlayReplySound: true,
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      add(ResetReplySound());
    });
  }

  void _isShowProductPreview(ProductPreview event, Emitter<ChatState> emit) {
    emit(state.copyWith(isShowProductPreview: event.isVisible));
  }

  void _onResetReplySound(ResetReplySound event, Emitter<ChatState> emit) {
    emit(state.copyWith(isPlayReplySound: false));
  }
}
