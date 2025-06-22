import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/profile_avatar_widget.dart';
import 'package:shamoapps/presentation/widgets/send_button_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({super.key});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, localizations),
      backgroundColor: CustomAppTheme.kRaisinBlackSecond,
      bottomNavigationBar: chatInput(localizations, context),
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

  Widget chatInput(AppLocalizations localizations, BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(
        top: CustomAppDimensions.kSize20,
        left: CustomAppDimensions.kSize20,
        right: CustomAppDimensions.kSize20,
        bottom: bottomInset > 0
            ? (bottomInset + CustomAppDimensions.kSize20)
            : CustomAppDimensions.kSize40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      style: CustomTextTheme.primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.typing_txt,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ),
              ),
              const SizedBox(width: CustomAppDimensions.kSize20),
              SendButtonWidget(
                onPressed: () {
                  
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
