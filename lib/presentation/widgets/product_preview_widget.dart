import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/animated_circle_close_button_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProductPreviewWidget extends StatelessWidget {
  const ProductPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: CustomAppDimensions.kSize225,
      height: CustomAppDimensions.kSize74,
      margin: const EdgeInsets.only(
        bottom: CustomAppDimensions.kSize20,
      ),
      padding: const EdgeInsets.all(CustomAppDimensions.kSize10),
      decoration: BoxDecoration(
        color: CustomAppTheme.kSpaceCadet,
        borderRadius: BorderRadius.circular(CustomAppDimensions.kSizeSmall),
        border: Border.all(
          color: CustomAppTheme.kPrimaryColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CustomAppDimensions.kSizeSmall),
            child: Image.asset(
              CustomAssets.kShoesImage,
              width: CustomAppDimensions.kSize54,
            ),
          ),
          const SizedBox(width: CustomAppDimensions.kSize10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.product_name,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: CustomAppDimensions.kSizeSuperSmall,
                ),
                Text(
                  localizations.price_nominal,
                  style: CustomTextTheme.priceTextStyle
                      .copyWith(fontWeight: CustomTextTheme.medium),
                ),
              ],
            ),
          ),
          AnimatedCircleCloseButtonWidget(onTap: () {}),
        ],
      ),
    );
  }
}
