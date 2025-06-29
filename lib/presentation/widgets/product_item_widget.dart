import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/domain/entity/chat.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.sender,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.addToCart,
    required this.onBuyNow,
  });

  final SenderType? sender;
  final String? productName;
  final String? imageUrl;
  final double? price;
  final VoidCallback? addToCart;
  final VoidCallback? onBuyNow;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isUser = sender == SenderType.sender;
    final width = MediaQuery.of(context).size.width;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(CustomAppDimensions.kSizeSmall),
        padding: const EdgeInsets.all(CustomAppDimensions.kSizeSmall),
        decoration: BoxDecoration(
          color: isUser
              ? CustomAppTheme.kSpaceCadet
              : CustomAppTheme.kRaisinBlackLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(CustomAppDimensions.kSizeSmall),
            topRight: const Radius.circular(CustomAppDimensions.kSizeSmall),
            bottomLeft:
                Radius.circular(isUser ? CustomAppDimensions.kSizeSmall : 0),
            bottomRight:
                Radius.circular(isUser ? 0 : CustomAppDimensions.kSizeSmall),
          ),
        ),
        constraints: BoxConstraints(maxWidth: width * .7),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    CustomAppDimensions.kSizeSmall,
                  ),
                  child: getImageProvider(
                    width: CustomAppDimensions.kSize70,
                    height: CustomAppDimensions.kSize70,
                    imageUrl ?? CustomAssets.kShoesImage,
                  ),
                ),
                const SizedBox(
                  width: CustomAppDimensions.kSize8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.product_name,
                        style: CustomTextTheme.primaryTextStyle
                            .copyWith(overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: CustomAppDimensions.kSizeSmallMedium,
                      ),
                      Text(
                        localizations.price_nominal,
                        style: CustomTextTheme.priceTextStyle.copyWith(
                          fontWeight: CustomTextTheme.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CustomAppDimensions.kSize20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: CustomAppTheme.kPrimaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CustomAppDimensions.kSize8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: CustomAppDimensions.kSizeMedium,
                      vertical: CustomAppDimensions.kSize10,
                    ),
                  ),
                  child: Text(
                    localizations.add_to_cart,
                    style: CustomTextTheme.purpleTextStyle,
                  ),
                ),
                const SizedBox(width: CustomAppDimensions.kSize8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: CustomAppTheme.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        CustomAppDimensions.kSizeSmall,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: CustomAppDimensions.kSizeMedium,
                      vertical: CustomAppDimensions.kSize10,
                    ),
                  ),
                  child: Text(
                    localizations.buy_now,
                    style: CustomTextTheme.spaceCadetTextStyle.copyWith(
                      fontWeight: CustomTextTheme.medium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Image getImageProvider(
    String url, {
    double width = 50.0,
    double height = 50.0,
  }) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        width: width,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        url,
        width: width,
        height: height,
      );
    }
  }
}
