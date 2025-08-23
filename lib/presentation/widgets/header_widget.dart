import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  final String title = 'Header Title';

  @override
  Widget build(BuildContext context) {
    // You can customize the header widget as needed
    // For example, you can add a title, logo, or any other widget
    // Here, we will just return a simple container with some margin
    // and a row containing a column with a text widget.
    // You can replace the Text widget with any other widget you want.
    final localization = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
        left: CustomAppDimensions.kSize30,
        right: CustomAppDimensions.kSize30,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  localization.greetings_hello,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeSuperLarge,
                    fontWeight: CustomTextTheme.semiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  maxLines: 1,
                  localization.user_name,
                  style: CustomTextTheme.subtitleTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.regular,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: CustomAppDimensions.kSize54,
            height: CustomAppDimensions.kSize54,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
