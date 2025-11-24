import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: CustomAppDimensions.kSizeSmall,
        horizontal: CustomAppDimensions.kSizeSmall,
      ),
      padding: const EdgeInsets.all(CustomAppDimensions.kSize20),
      decoration: BoxDecoration(
        color: CustomAppTheme.kRaisinBlackLight,
        borderRadius: BorderRadius.circular(
          CustomAppDimensions.kSizeSmall,
        ),
      ),
      child: paymentSummaryContent(context, localizations),
    );
  }

  Widget paymentSummaryContent(
      BuildContext context, AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.payment_summary,
          style: CustomTextTheme.primaryTextStyle.copyWith(
            fontWeight: CustomTextTheme.medium,
            fontSize: CustomAppDimensions.kSizeLarge,
          ),
        ),
        const SizedBox(
          height: CustomAppDimensions.kSizeSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.product_quantity,
              style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeSmall,
                fontWeight: CustomTextTheme.regular,
              ),
            ),
            Text(
              '2 Items',
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: CustomAppDimensions.kSizeSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.product_price,
              style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeSmall,
                fontWeight: CustomTextTheme.regular,
              ),
            ),
            Text(
              localizations.price_nominal,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: CustomAppDimensions.kSizeSmall,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.shipping,
              style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeSmall,
                fontWeight: CustomTextTheme.regular,
              ),
            ),
            Text(
              localizations.free,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
          ],
        ),
        const SizedBox(height: CustomAppDimensions.kSizeSmall),
        const Divider(
          thickness: CustomAppDimensions.kThicknessThin,
          color: CustomAppTheme.kSpaceCadetLight,
        ),
        const SizedBox(height: CustomAppDimensions.kSize10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.total,
              style: CustomTextTheme.priceTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.semiBold,
              ),
            ),
            Text(
              localizations.price_nominal,
              style: CustomTextTheme.priceTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.semiBold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
