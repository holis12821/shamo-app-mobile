import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class WishlistCardWidget extends StatelessWidget {
  const WishlistCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSizeSmall,
        left: CustomAppDimensions.kSizeSmall,
        right: CustomAppDimensions.kSizeSmall,
        bottom: CustomAppDimensions.kSizeSuperSmall,
      ),
      padding: const EdgeInsets.only(
        top: CustomAppDimensions.kSize10,
        left: CustomAppDimensions.kSizeSmall,
        bottom: CustomAppDimensions.kSizeMedium,
        right: CustomAppDimensions.kSize20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          CustomAppDimensions.kSizeSmall,
        ),
        color: CustomAppTheme.kRaisinBlackLight,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(
              CustomAppDimensions.kSizeSmall,
            ),
            child: Image.asset(
              'assets/images/shoes.png',
              width: CustomAppDimensions.kSize60,
            ),
          ),
          const SizedBox(width: CustomAppDimensions.kSizeSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.product_name,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontWeight: CustomTextTheme.semiBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: CustomAppDimensions.kSizeSuperSmall),
                Text(
                  localizations.price_nominal,
                  style: CustomTextTheme.priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/ic_wishlist_active.svg',
              width: CustomAppDimensions.kSize34,
            ),
          ),
        ],
      ),
    );
  }
}
