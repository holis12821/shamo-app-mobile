import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class PopularProductsWidgets extends StatelessWidget {
  const PopularProductsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          popularTitle(localization),
          sectionProductPopular(localization),
        ],
      ),
    );
  }

  Widget popularTitle(AppLocalizations localization) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: CustomAppDimensions.kSize30,
        ),
        child: Text(
          localization.popular_products,
          style: CustomTextTheme.primaryTextStyle.copyWith(
            fontSize: CustomAppDimensions.kSizeMediumLarge,
            fontWeight: CustomTextTheme.semiBold,
          ),
        ),
      ),
    );
  }

  Widget sectionProductPopular(AppLocalizations localizations) {
    return Container(
      height: CustomAppDimensions.kSize278,
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSizeMedium,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: CustomAppDimensions.kSizeMediumLarge,
          right: CustomAppDimensions.kSizeMediumLarge,
        ),
        itemBuilder: (context, index) {
          return productCard(localizations, index);
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 4, // Adjust the number of items as needed
      ),
    );
  }

  Widget productCard(AppLocalizations localization, int index) {
    return Container(
      width: CustomAppDimensions.kSize215,
      height: CustomAppDimensions.kSize278,
      margin: const EdgeInsets.only(
        left: CustomAppDimensions.kSize8,
        right: CustomAppDimensions.kSize8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomAppDimensions.kSize20,
        ),
        color: CustomAppTheme.kAntiFlashWhite,
        boxShadow: [
          BoxShadow(
            color: CustomAppTheme.kDavysGray.withValues(alpha: .2),
            blurRadius: CustomAppDimensions.kSize10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: CustomAppDimensions.kSize30,
          ),
          Image.asset(
            CustomAssets.kShoesImage,
            width: CustomAppDimensions.kSize215,
            height: CustomAppDimensions.kSize150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: CustomAppDimensions.kSize20,
              right: CustomAppDimensions.kSize20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: CustomAppDimensions.kSize6,
                ),
                Text(
                  localization.hiking_shoes,
                  style: CustomTextTheme.secondaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeSmall,
                  ),
                ),
                const SizedBox(
                  height: CustomAppDimensions.kSize6,
                ),
                Text(
                  localization.court_vision,
                  style: CustomTextTheme.jetTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
                    fontWeight: CustomTextTheme.semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: CustomAppDimensions.kSize6,
                ),
                Text(
                  localization.price_nominal,
                  style: CustomTextTheme.priceTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                    fontWeight: CustomTextTheme.medium,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
