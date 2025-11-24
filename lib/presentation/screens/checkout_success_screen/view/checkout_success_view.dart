import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CheckoutSuccessView extends StatelessWidget {
  const CheckoutSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: header(localizations),
      backgroundColor: CustomAppTheme.kRaisinBlackSecond,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                CustomAssets.kIconCart,
              ),
            ),
            const SizedBox(
              height: CustomAppDimensions.kSize20,
            ),
            Text(
              localizations.you_made_a_transaction,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeLarge,
                  fontWeight: CustomTextTheme.medium),
            ),
            const SizedBox(
              height: CustomAppDimensions.kSizeSmall,
            ),
            Text(
              localizations.stay_home_wait_for_the_item,
              style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.regular,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              width: CustomAppDimensions.kSize192,
              height: CustomAppDimensions.kSize44,
              margin: const EdgeInsets.only(
                top: CustomAppDimensions.kSize30,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: CustomAppTheme.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      CustomAppDimensions.kSizeSmall,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                child: Text(
                  localizations.order_other_items,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.medium,
                  ),
                ),
              ),
            ),
            Container(
              width: CustomAppDimensions.kSize192,
              height: CustomAppDimensions.kSize44,
              margin: const EdgeInsets.only(
                top: CustomAppDimensions.kSizeSmall,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: CustomAppTheme.kSpaceIndigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      CustomAppDimensions.kSizeSmall,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  localizations.view_my_orders,
                  style: CustomTextTheme.paleSlateTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget header(AppLocalizations localizations) {
    return AppBar(
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      centerTitle: true,
      title: Text(
        localizations.checkout_success_title,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontWeight: CustomTextTheme.medium,
          fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
        ),
      ),
    );
  }
}
