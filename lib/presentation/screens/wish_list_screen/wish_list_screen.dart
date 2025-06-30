import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/widgets/wishlist_card_widget.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          headerWishList(localizations),
          const Divider(
            thickness: 1,
            color: CustomAppTheme.kRaisinPrimaryColor,
          ),
          // emptyWishList(localizations),
          wishlistContent(),
        ],
      ),
    );
  }

  Widget headerWishList(AppLocalizations localizations) {
    return AppBar(
      backgroundColor: CustomAppTheme.kRaisinBlackSecond,
      centerTitle: true,
      title: Text(
        localizations.favorite_shoes,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
          fontWeight: CustomTextTheme.medium,
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget emptyWishList(AppLocalizations localizations) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: CustomAppTheme.kRaisinBlackSecond,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_wishlist_empty.svg',
              width: CustomAppDimensions.kSize74,
            ),
            const SizedBox(
              height: CustomAppDimensions.kSize23,
            ),
            Text(
              localizations.empty_wishlist_shoes,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
            const SizedBox(height: CustomAppDimensions.kSizeSmall),
            Text(
              localizations.find_favorite_shoes,
              style: CustomTextTheme.secondaryTextStyle,
            ),
            const SizedBox(height: CustomAppDimensions.kSize20),
            SizedBox(
              height: CustomAppDimensions.kSize44,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: CustomAppDimensions.kSize10,
                    horizontal: CustomAppDimensions.kSize24,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget wishlistContent() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: CustomAppTheme.kRaisinBlackSecond,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(
            CustomAppDimensions.kSize18,
          ),
          itemCount: 5,
          itemBuilder: (context, index) => const WishlistCardWidget(),
          shrinkWrap: true,
        ),
      ),
    );
  }
}
