import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: headerProfile(context),
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            contentProfile(context, localizations),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget headerProfile(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: screenHeight * 0.12,
      title: Container(
        padding: const EdgeInsets.only(
          top: CustomAppDimensions.kSize30,
          left: CustomAppDimensions.kSize30,
          right: CustomAppDimensions.kSizeLarge,
          bottom: CustomAppDimensions.kSize30,
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: CustomAppDimensions.kSize64,
              ),
            ),
            const SizedBox(width: CustomAppDimensions.kSizeLarge),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, Alex',
                    style: CustomTextTheme.primaryTextStyle.copyWith(
                        fontSize: CustomAppDimensions.kSizeSuperLarge,
                        fontWeight: CustomTextTheme.semiBold,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  const SizedBox(height: CustomAppDimensions.kSize6),
                  Text(
                    'Software Engineer',
                    style: CustomTextTheme.subtitleTextStyle.copyWith(
                      fontSize: CustomAppDimensions.kSizeLarge,
                      fontWeight: CustomTextTheme.regular,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/ic_exit_button.svg',
                width: CustomAppDimensions.kSize20,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget contentProfile(
    BuildContext context,
    AppLocalizations localizations,
  ) {
    final accountItems = [
      'Edit Profile',
      'Your Orders',
      'Help',
    ];

    final generalItems = [
      'Privacy & Policy',
      'Terms of Service',
      'Rate App',
    ];

    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: CustomAppDimensions.kSize20,
          left: CustomAppDimensions.kSize30,
          right: CustomAppDimensions.kSize30,
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
            Text(
              localizations.account_wording,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
                fontWeight: CustomTextTheme.semiBold,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: accountItems.length,
              itemBuilder: (context, index) {
                return menuItem(context, accountItems[index]);
              },
            ),
            const SizedBox(height: CustomAppDimensions.kSize30),
            Text(
              localizations.general,
              style: CustomTextTheme.primaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
                fontWeight: CustomTextTheme.semiBold,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: generalItems.length,
              itemBuilder: (context, index) {
                return menuItem(context, generalItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context, String txt) {
    final routeName = switch (txt) {
      'Edit Profile' => '/edit-profile',
      'Your Orders' => '/your-orders',
      'Help' => '/help',
      'Privacy & Policy' => '/privacy-policy',
      'Terms of Service' => '/terms-of-service',
      'Rate App' => '/rate-app',
      _ => '',
    };

    return InkWell(
      onTap: () {
        if (routeName.isNotEmpty) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: CustomAppDimensions.kSizeLarge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt,
              style: CustomTextTheme.secondaryTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeMediumSmall,
                fontWeight: CustomTextTheme.regular,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: CustomAppTheme.kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
