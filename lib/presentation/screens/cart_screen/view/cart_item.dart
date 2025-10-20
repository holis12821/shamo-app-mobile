import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void increase() => setState(() => quantity++);
  void decrease() {
    if (quantity > 1) {
      setState(() => quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize10,
        left: CustomAppDimensions.kSizeSmall,
        right: CustomAppDimensions.kSizeSmall,
        bottom: CustomAppDimensions.kSize10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: CustomAppDimensions.kSizeMedium,
        vertical: CustomAppDimensions.kSize10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomAppDimensions.kSizeSmall),
          color: CustomAppTheme.kRaisinBlackLight),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(CustomAppDimensions.kSizeSmall),
                child: Image.asset(
                  CustomAssets.kShoesImage,
                  width: CustomAppDimensions.kSize60,
                  height: CustomAppDimensions.kSize60,
                  fit: BoxFit.cover,
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
                        fontSize: CustomAppDimensions.kSizeMedium,
                        fontWeight: CustomTextTheme.semiBold,
                      ),
                    ),
                    const SizedBox(height: CustomAppDimensions.kSizeSuperSmall),
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
              SizedBox(
                child: Column(
                  children: [
                    InkWell(
                      onTap: increase,
                      child: SvgPicture.asset(
                        CustomAssets.kIconAddCirclePrimary,
                        width: CustomAppDimensions.kSizeLarge,
                        height: CustomAppDimensions.kSizeLarge,
                      ),
                    ),
                    const SizedBox(height: CustomAppDimensions.kSizeSuperSmall),
                    Text(
                      quantity.toString(),
                      style: CustomTextTheme.primaryTextStyle.copyWith(
                        fontSize: CustomAppDimensions.kSizeMedium,
                        fontWeight: CustomTextTheme.medium,
                      ),
                    ),
                    const SizedBox(height: CustomAppDimensions.kSizeSuperSmall),
                    InkWell(
                      onTap: decrease,
                      child: SvgPicture.asset(
                        CustomAssets.kIconRemoveCirclePrimary,
                        width: CustomAppDimensions.kSizeLarge,
                        height: CustomAppDimensions.kSizeLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        CustomAssets.kIconTrashRed,
                        width: CustomAppDimensions.kSizeSmall,
                        height: CustomAppDimensions.kSizeSmall,
                      ),
                      const SizedBox(
                          width: CustomAppDimensions.kSizeSmallMedium),
                      Text(
                        localizations.remove,
                        style: CustomTextTheme.kAlertColorTextStyle.copyWith(
                          fontSize: CustomAppDimensions.kSizeMedium,
                          fontWeight: CustomTextTheme.light,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
