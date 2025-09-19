import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/product_card.dart';
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
          sectionProductPopular(),
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

  Widget sectionProductPopular() {
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
          return const ProductCard();
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 4, // Adjust the number of items as needed
      ),
    );
  }
}
