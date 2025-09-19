import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product'),
      child: Container(
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
              CustomAssets.kShoesNikeDetail,
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
      ),
    );
  }
}
