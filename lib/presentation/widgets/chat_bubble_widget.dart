import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/domain/entity/chat.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    super.key,
    required this.text,
    required this.sender,
  });

  final String? text;
  final SenderType? sender;

  @override
  Widget build(BuildContext context) {
    final isUser = sender == SenderType.sender;
    final width = MediaQuery.of(context).size.width;
    final localizations = AppLocalizations.of(context)!;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: CustomAppDimensions.kSizeLarge,
          vertical: CustomAppDimensions.kSize6,
        ),
        padding: const EdgeInsets.all(CustomAppDimensions.kSizeSmall),
        constraints: BoxConstraints(maxWidth: width * .75),
        decoration: BoxDecoration(
          color: isUser
              ? CustomAppTheme.kSpaceCadet
              : CustomAppTheme.kRaisinBlackLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(CustomAppDimensions.kSizeSmall),
            topRight: const Radius.circular(CustomAppDimensions.kSizeSmall),
            bottomLeft:
                Radius.circular(isUser ? CustomAppDimensions.kSizeSmall : 0),
            bottomRight:
                Radius.circular(isUser ? 0 : CustomAppDimensions.kSizeSmall),
          ),
        ),
        child: Text(
          text ?? localizations.chat_message,
          style: CustomTextTheme.primaryTextStyle,
        ),
      ),
    );
  }
}
