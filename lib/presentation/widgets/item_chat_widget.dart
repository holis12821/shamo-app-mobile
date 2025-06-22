import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ItemChatWidget extends StatelessWidget {
  const ItemChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail-chat'),
      child: Container(
        margin: const EdgeInsets.only(
          top: CustomAppDimensions.kSizeMediumSmall,
          left: CustomAppDimensions.kSize8,
          right: CustomAppDimensions.kSize8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  CustomAssets.kIconLogo,
                  width: CustomAppDimensions.kSize54,
                ),
                const SizedBox(
                  width: CustomAppDimensions.kSizeSmall,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.shoe_store,
                        style: CustomTextTheme.primaryTextStyle
                            .copyWith(fontSize: CustomAppDimensions.kSize15),
                      ),
                      Text(
                        localizations.chat_content,
                        style: CustomTextTheme.secondaryTextStyle.copyWith(
                          fontSize: CustomAppDimensions.kSizeMedium,
                          fontWeight: CustomTextTheme.light,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Text(
                  localizations.now,
                  style: CustomTextTheme.secondaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSize10
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
