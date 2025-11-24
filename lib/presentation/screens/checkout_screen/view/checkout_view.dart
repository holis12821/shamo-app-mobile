import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/address_detail_widget.dart';
import 'package:shamoapps/presentation/widgets/checkout_card.dart';
import 'package:shamoapps/presentation/widgets/payment_summary_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final screenHeight = MediaQuery.of(context).size.height;
    final heightWidget = screenHeight * (60 / screenHeight);

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      appBar: buildAppBar(context, heightWidget, localizations),
      body: SafeArea(
        child: SingleChildScrollView(
          child: contentBody(context, localizations),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: customBottomNav(context, localizations),
    );
  }

  PreferredSizeWidget buildAppBar(
    BuildContext context,
    double heightWidget,
    AppLocalizations localizations,
  ) {
    return AppBar(
      toolbarHeight: heightWidget,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      title: Text(
        localizations.checkout_title,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontWeight: CustomTextTheme.medium,
          fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: CustomAppTheme.kGhostWhite,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
    );
  }

  Widget contentBody(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: CustomAppDimensions.kSizeMediumSemiMedium,
        horizontal: CustomAppDimensions.kSizeMediumSemiMedium,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomAppTheme.kRaisinBlackSecond,
            CustomAppTheme.kRaisinPrimaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CustomAppDimensions.kSize30),
          topRight: Radius.circular(CustomAppDimensions.kSize30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: CustomAppDimensions.kSizeSmall,
              left: CustomAppDimensions.kSizeSmall,
            ),
            child: Text(
              localizations.list_items,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              vertical: CustomAppDimensions.kSizeSmall,
              horizontal: CustomAppDimensions.kSizeSmall,
            ),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlackLight,
              borderRadius: BorderRadius.circular(
                CustomAppDimensions.kSizeSmall,
              ),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const CheckoutCard();
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: CustomAppDimensions.kThicknessThin,
                  color: CustomAppTheme.kSpaceCadetLight,
                );
              },
              itemCount: 2,
            ),
          ),
          const AddressDetailWidget(),
          const PaymentSummaryWidget(),
        ],
      ),
    );
  }

  Widget customBottomNav(BuildContext context, AppLocalizations localizations) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: CustomAppDimensions.kThicknessThin,
          color: CustomAppTheme.kSpaceCadetLight,
        ),
        SizedBox(
          height: CustomAppDimensions.kSize100,
          child: Container(
            width: double.infinity,
            height: CustomAppDimensions.kSize50,
            margin: const EdgeInsets.only(
              top: CustomAppDimensions.kSizeSmall,
              left: CustomAppDimensions.kSize30,
              right: CustomAppDimensions.kSize30,
              bottom: CustomAppDimensions.kSize30,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomAppTheme.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    CustomAppDimensions.kSizeSmall,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "/checkout-success", (route) => false);
              },
              child: Text(
                localizations.checkout_now,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeLarge,
                  fontWeight: CustomTextTheme.semiBold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
