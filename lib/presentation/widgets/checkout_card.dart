import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: CustomAppDimensions.kSize20,
        horizontal: CustomAppDimensions.kSizeSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: CustomAppDimensions.kSize60,
            height: CustomAppDimensions.kSize60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                CustomAppDimensions.kSizeSmall,
              ),
              image: const DecorationImage(
                image: AssetImage(CustomAssets.kShoesImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: CustomAppDimensions.kSize20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.product_name,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                    fontWeight: CustomTextTheme.semiBold,
                  ),
                ),
                const SizedBox(
                  height: CustomAppDimensions.kSize6,
                ),
                Text(
                  localizations.price_nominal,
                  style: CustomTextTheme.priceTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                    fontWeight: CustomTextTheme.regular,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '2 Items',
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeSmall,
              fontWeight: CustomTextTheme.regular,
            ),
          )
        ],
      ),
    );
  }
}