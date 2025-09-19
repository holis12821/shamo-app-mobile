import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProductNewArrivals extends StatelessWidget {
  const ProductNewArrivals({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product'),
      child: Container(
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
                CustomAssets.kShoesNikeDetail,
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
      ),
    );
  }
}