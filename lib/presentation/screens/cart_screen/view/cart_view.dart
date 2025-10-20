import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/screens/cart_screen/view/cart_item.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final screenHeight = MediaQuery.of(context).size.height;
    final heightWidget = screenHeight * (60 / screenHeight);

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      appBar: headerCart(context, heightWidget, localizations),
      body: SafeArea(
        child: SingleChildScrollView(
          child: contentCart(
            heightWidget,
            context,
            localizations,
          ),
        ),
      ),
      bottomNavigationBar: customBottomNav(localizations),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget headerCart(
    BuildContext context,
    double headerHeight,
    AppLocalizations localizations,
  ) {
    return AppBar(
      toolbarHeight: headerHeight,
      centerTitle: true,
      elevation: 0,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      title: Text(
        localizations.cart_title,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
          fontWeight: CustomTextTheme.medium,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: CustomAppTheme.kGhostWhite,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: true,
      actionsPadding: const EdgeInsets.only(
        right: CustomAppDimensions.kSizeMediumSemiMedium,
      ),
    );
  }

  Widget contentCart(
      double height, BuildContext context, AppLocalizations localizations) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              CustomAppTheme.kRaisinBlackSecond,
              CustomAppTheme.kRaisinPrimaryColor,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CustomAppDimensions.kSize30),
            topRight: Radius.circular(CustomAppDimensions.kSize30),
          ),
        ),
        child: cartList(),
      ),
    );
  }

  Widget cartList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(
        CustomAppDimensions.kSizeMediumSemiMedium,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const CartItem();
      },
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }

  Widget customBottomNav(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSizeSuperSmall,
      ),
      height: CustomAppDimensions.kSize180,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: CustomAppDimensions.kSize30,
              vertical: CustomAppDimensions.kSizeMediumSemiMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.subtotal,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                    fontWeight: CustomTextTheme.regular,
                  ),
                ),
                Text(
                  localizations.price_nominal,
                  style: CustomTextTheme.priceTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeLarge,
                    fontWeight: CustomTextTheme.semiBold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: CustomAppTheme.kRaisinBlack,
            thickness: CustomAppDimensions.kBorderThicknessStandard,
          ),
          Container(
            width: double.infinity,
            height: CustomAppDimensions.kSize50,
            margin: const EdgeInsets.symmetric(
              horizontal: CustomAppDimensions.kSize30,
              vertical: CustomAppDimensions.kSizeSmall,
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: CustomAppTheme.kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomAppDimensions.kSize20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    CustomAppDimensions.kSizeSmall,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localizations.checkout,
                    style: CustomTextTheme.primaryTextStyle.copyWith(
                      fontSize: CustomAppDimensions.kSizeLarge,
                      fontWeight: CustomTextTheme.semiBold,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: CustomAppTheme.kGhostWhite,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emptyCart(BuildContext context, AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            CustomAssets.kIconEmptyCart,
            width: CustomAppDimensions.kSize80,
            height: CustomAppDimensions.kSize69,
          ),
          const SizedBox(
            height: CustomAppDimensions.kSize20,
          ),
          Text(
            localizations.your_cart_empty,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSizeSmall,
          ),
          Text(
            localizations.find_favorite_shoes,
            style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMedium,
                fontWeight: CustomTextTheme.regular),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSize20,
          ),
          SizedBox(
            height: CustomAppDimensions.kSize44,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: CustomAppDimensions.kSize10,
                  horizontal: CustomAppDimensions.kSizeSuperLarge,
                ),
                backgroundColor: CustomAppTheme.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(CustomAppDimensions.kSizeSmall),
                ),
              ),
              child: Text(
                localizations.explore_store,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeLarge,
                  fontWeight: CustomTextTheme.medium,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
