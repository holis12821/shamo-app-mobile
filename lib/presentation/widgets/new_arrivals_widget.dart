import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class NewArrivalsWidget extends StatelessWidget {
  const NewArrivalsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
        left: CustomAppDimensions.kSize30,
        right: CustomAppDimensions.kSize30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newArrivalsWidgetTitle(localizations),

        ],
      ),
    );
  }

  Widget newArrivalsWidgetTitle(AppLocalizations localizations) {
    return SizedBox(
      child: Text(
        localizations.new_arrivals,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeMediumLarge,
          fontWeight: CustomTextTheme.semiBold,
        ),
      ),
    );
  }

  

}