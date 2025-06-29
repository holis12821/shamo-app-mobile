import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/domain/entity/chat.dart';
import 'package:shamoapps/helper/sound_helper.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_bloc.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_event.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_state.dart';
import 'package:shamoapps/presentation/widgets/chat_bubble_widget.dart';
import 'package:shamoapps/presentation/widgets/product_item_widget.dart';
import 'package:shamoapps/presentation/widgets/product_preview_widget.dart';
import 'package:shamoapps/presentation/widgets/profile_avatar_widget.dart';
import 'package:shamoapps/presentation/widgets/send_button_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class DetailChatView extends StatefulWidget {
  const DetailChatView({super.key});

  @override
  State<DetailChatView> createState() => _DetailChatViewState();
}

class _DetailChatViewState extends State<DetailChatView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  Timer? _scrollDebounce;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(ProductPreview(true));
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollDebounce?.isActive ?? false) return;
    _scrollDebounce = Timer(const Duration(milliseconds: 300), () {});
  }

  void _onSend() {
    final text = _controller.text;
    if (text.trim().isNotEmpty && !_isSending) {
      setState(() => _isSending = true);
      context.read<ChatBloc>().add(SendMessage(text));
      _controller.clear();

      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) setState(() => _isSending = false);
      });

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 150), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (prev, curr) {
        final hasNewMessage = prev.chatList.length < curr.chatList.length;
        final typingChanged = prev.isTyping != curr.isTyping;
        final justReplied = curr.isPlayReplySound && !prev.isPlayReplySound;

        return hasNewMessage || typingChanged || justReplied;
      },
      listener: (context, state) async {
        if (state.isPlayReplySound) {
          await SoundHelper.playSendSound();
        }

        _scrollToBottom();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar(context, localizations),
        backgroundColor: CustomAppTheme.kRaisinBlackSecond,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildChatList(localizations),
              ),
            ],
          ),
        ),
        bottomNavigationBar: chatInput(localizations, context),
      ),
    );
  }

  PreferredSizeWidget appBar(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
        CustomAppDimensions.kSize60,
      ),
      child: AppBar(
        backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
        centerTitle: false,
        leading: IconButton(
          color: CustomAppTheme.kAntiFlashWhite,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const ProfileAvatarWidget(
                imageUrl: CustomAssets.kIconLogo, isOnline: true),
            const SizedBox(
              width: CustomAppDimensions.kSizeSmall,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.shoe_store,
                    style: CustomTextTheme.primaryTextStyle.copyWith(
                      fontSize: CustomAppDimensions.kSizeMedium,
                      fontWeight: CustomTextTheme.medium,
                    ),
                  ),
                  Text(
                    localizations.online,
                    style: CustomTextTheme.secondaryTextStyle.copyWith(
                        fontSize: CustomAppDimensions.kSizeMedium,
                        fontWeight: CustomTextTheme.light),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(AppLocalizations localizations) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final messages = state.chatList;
        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.only(
            top: state.isShowProductPreview ? CustomAppDimensions.kSize18 : 0,
            left: CustomAppDimensions.kSize18,
            right: CustomAppDimensions.kSize18,
            bottom: CustomAppDimensions.kSize18,
          ),
          itemCount: messages.length + (state.isTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (state.isTyping && index == messages.length) {
              return ChatBubbleWidget(
                text: localizations.typing_txt,
                sender: SenderType.receiver,
              );
            }

            final item = messages[index];
            return item.type == ChatType.product
                ? ProductItemWidget(
                    productName: item.product?.name ?? '',
                    imageUrl: item.product?.imageUrl,
                    price: item.product?.price,
                    addToCart: () {},
                    onBuyNow: () {},
                    sender: SenderType.sender,
                  )
                : ChatBubbleWidget(
                    text: item.text,
                    sender: item.sender,
                  );
          },
          shrinkWrap: true,
        );
      },
    );
  }

  Widget chatInput(AppLocalizations localizations, BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(
            top: CustomAppDimensions.kSizeSuperSmall,
            left: CustomAppDimensions.kSize20,
            right: CustomAppDimensions.kSize20,
            bottom: bottomInset > 0
                ? (bottomInset + CustomAppDimensions.kSize20)
                : CustomAppDimensions.kSize20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: state.isShowProductPreview,
                child: const ProductPreviewWidget(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: CustomAppDimensions.kSize45,
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomAppDimensions.kSizeLarge,
                      ),
                      decoration: BoxDecoration(
                        color: CustomAppTheme.kRaisinBlackLight,
                        borderRadius: BorderRadius.circular(
                          CustomAppDimensions.kSizeSmall,
                        ),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _controller,
                          style: CustomTextTheme.primaryTextStyle,
                          decoration: InputDecoration.collapsed(
                            hintText: localizations.typing_txt,
                            hintStyle: CustomTextTheme.subtitleTextStyle,
                          ),
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (_) => _onSend(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: CustomAppDimensions.kSize20),
                  SendButtonWidget(
                    onPressed: _onSend,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
