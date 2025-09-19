import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/product_new_arrivals.dart';
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
          sectionNewArrivals(),
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

  Widget sectionNewArrivals() {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSizeMedium),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: CustomAppDimensions.kSizeMediumLarge,
          right: CustomAppDimensions.kSizeMediumLarge,
        ),
        itemBuilder: (context, index) {
          return const ProductNewArrivals();
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4,
      ),
    );
  }
}
