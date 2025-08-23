import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/item_chat_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      appBar: headerChat(context, localizations),
      body: SafeArea(
        child: Column(
          children: [
            contentChat(localizations),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget headerChat(BuildContext context, AppLocalizations localization) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * (60 / screenHeight);

    return AppBar(
      toolbarHeight: headerHeight,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      centerTitle: true,
      title: Text(
        localization.message_support,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeMediumLarge,
          fontWeight: CustomTextTheme.semiBold,
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget emptyChat(AppLocalizations localizations) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomAppTheme.kRaisinBlackSecond,
              CustomAppTheme.kRaisinPrimaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: CustomAppDimensions.kSize80,
              child: Image.asset(CustomAssets.kIconHeadset),
            ),
            const SizedBox(
              height: CustomAppDimensions.kSize20,
            ),
            Text(
              localizations.oopss_no_message_yet,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
            const SizedBox(
              height: CustomAppDimensions.kSizeSmall,
            ),
            Text(
              localizations.never_done_transaction,
              style: CustomTextTheme.secondaryTextStyle,
            ),
            const SizedBox(
              height: CustomAppDimensions.kSize20,
            ),
            SizedBox(
              height: CustomAppDimensions.kSize44,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CustomAppDimensions.kSizeSuperLarge,
                    vertical: CustomAppDimensions.kSize10,
                  ),
                  backgroundColor: CustomAppTheme.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(CustomAppDimensions.kSizeSmall),
                  ),
                ),
                child: Text(
                  localizations.explore_store,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contentChat(AppLocalizations localizations) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomAppTheme.kRaisinBlackSecond,
              CustomAppTheme.kRaisinPrimaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.only(
            top: CustomAppDimensions.kSize20,
            left: CustomAppDimensions.kSizeMediumLarge,
            right: CustomAppDimensions.kSizeMediumLarge,
          ),
          itemBuilder: (context, index) {
            return const ItemChatWidget();
          },
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(top: CustomAppDimensions.kSizeSmall),
              child: Divider(
                thickness: 1,
                color: CustomAppTheme.kRaisinBlack,
              ),
            );
          },
        ),
      ),
    );
  }
}
