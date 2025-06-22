import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newArrivalsWidgetTitle(localizations),
          sectionNewArrivals(localizations),
        ],
      ),
    );
  }

  Widget newArrivalsWidgetTitle(AppLocalizations localizations) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: CustomAppDimensions.kSize30,
        ),
        child: Text(
          localizations.new_arrivals,
          style: CustomTextTheme.primaryTextStyle.copyWith(
            fontSize: CustomAppDimensions.kSizeMediumLarge,
            fontWeight: CustomTextTheme.semiBold,
          ),
        ),
      ),
    );
  }

  Widget sectionNewArrivals(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSizeMedium),
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: CustomAppDimensions.kSizeMediumLarge,
          right: CustomAppDimensions.kSizeMediumLarge,
        ),
        itemBuilder: (context, index) {
          return productArrivalsCard(localizations, index);
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4,
      ),
    );
  }

  Widget productArrivalsCard(AppLocalizations localizations, int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: CustomAppDimensions.kSize8,
        left: CustomAppDimensions.kSize8,
        right: CustomAppDimensions.kSize8,
        bottom: CustomAppDimensions.kSizeMediumLarge,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              CustomAppDimensions.kSize20,
            ),
            child: Image.asset(
              CustomAssets.kShoesImage,
              width: CustomAppDimensions.kSize120,
              height: CustomAppDimensions.kSize120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: CustomAppDimensions.kSizeSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.basketball_shoes,
                  style: CustomTextTheme.secondaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeSmall,
                    fontWeight: CustomTextTheme.regular,
                  ),
                ),
                const SizedBox(height: CustomAppDimensions.kSize6),
                Text(
                  localizations.court_vision,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.semiBold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: CustomAppDimensions.kSize6),
                Text(
                  localizations.price_nominal,
                  style: CustomTextTheme.priceTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                    fontWeight: CustomTextTheme.medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
