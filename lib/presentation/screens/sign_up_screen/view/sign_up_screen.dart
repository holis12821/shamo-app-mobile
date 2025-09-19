import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: CustomAppDimensions.kSize30,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: CustomAppDimensions.kSize30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(localizations.txt_sign_up),
                      const SizedBox(
                          height: CustomAppDimensions.kSizeSuperSmall),
                      Text(
                        localizations.register_and_happy_shopping,
                        style: CustomTextTheme.subtitleTextStyle,
                      ),
                      inputFullNameFormComponent(localizations),
                      inputUsernameFormComponent(localizations),
                      inputEmailFormComponent(localizations),
                      inputPasswordFormComponent(localizations),
                      signUpButton(context, localizations.txt_sign_up),
                    ],
                  ),
                ),
              ),
              footer(context, localizations),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String title) {
    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
      ),
      child: Text(
        title,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeSuperLarge,
          fontWeight: CustomTextTheme.semiBold,
        ),
      ),
    );
  }

  Widget footer(BuildContext context, AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(bottom: CustomAppDimensions.kSize30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.txt_footer_already_have_account,
            style: CustomTextTheme.subtitleTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeSmall,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              localizations.txt_sign_in,
              style: CustomTextTheme.purpleTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeSmall,
                fontWeight: CustomTextTheme.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputFullNameFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.full_name,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSizeSmall,
          ),
          Container(
            height: CustomAppDimensions.kSize50,
            padding: const EdgeInsets.symmetric(
              horizontal: CustomAppDimensions.kSizeLarge,
            ),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius:
                  BorderRadius.circular(CustomAppDimensions.kSizeLarge),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_profile_active.svg',
                    width: CustomAppDimensions.kSizeLarge,
                  ),
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_full_name,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputUsernameFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.username,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSizeSmall,
          ),
          Container(
            height: CustomAppDimensions.kSize50,
            padding: const EdgeInsets.symmetric(
              horizontal: CustomAppDimensions.kSizeLarge,
            ),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius:
                  BorderRadius.circular(CustomAppDimensions.kSizeLarge),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_union.svg',
                    width: CustomAppDimensions.kSizeLarge,
                  ),
                  const SizedBox(
                    width: CustomAppDimensions.kSizeLarge,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_username,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputEmailFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.email_address,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSizeSmall,
          ),
          Container(
            height: CustomAppDimensions.kSize50,
            padding: const EdgeInsets.symmetric(
              horizontal: CustomAppDimensions.kSizeLarge,
            ),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius:
                  BorderRadius.circular(CustomAppDimensions.kSizeLarge),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_email.svg',
                    width: 17,
                  ),
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_email_address,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputPasswordFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.password,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(
            height: CustomAppDimensions.kSizeSmall,
          ),
          Container(
            height: CustomAppDimensions.kSize50,
            padding: const EdgeInsets.symmetric(
                horizontal: CustomAppDimensions.kSizeLarge),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius:
                  BorderRadius.circular(CustomAppDimensions.kSizeSmall),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_password.svg',
                    width: CustomAppDimensions.kSizeLarge,
                  ),
                  const SizedBox(
                    width: CustomAppDimensions.kSizeLarge,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                          hintText: localizations.hint_password,
                          hintStyle: CustomTextTheme.subtitleTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUpButton(BuildContext context, String textButton) {
    return Container(
      width: double.infinity,
      height: CustomAppDimensions.kSize50,
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        style: TextButton.styleFrom(
            backgroundColor: CustomAppTheme.kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(CustomAppDimensions.kSizeSmall))),
        child: Text(
          textButton,
          style: CustomTextTheme.primaryTextStyle.copyWith(
            fontSize: CustomAppDimensions.kSizeLarge,
            fontWeight: CustomTextTheme.medium,
          ),
        ),
      ),
    );
  }
}
