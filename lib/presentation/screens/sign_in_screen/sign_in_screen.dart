import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: CustomAppDimensions.defaultMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(localizations.login),
              const SizedBox(height: 2),
              Text(
                localizations.sign_in_to_continue,
                style: CustomTextTheme.subtitleTextStyle,
              ),
              inputEmailFormComponent(localizations),
              inputPasswordFormComponent(localizations),
              signInButton(localizations.txt_button_sign_in),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(String title) {
    return Container(
      margin: EdgeInsets.only(
        top: CustomAppDimensions.defaultMargin,
      ),
      child: Text(
        title,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: 24,
          fontWeight: CustomTextTheme.semiBold,
        ),
      ),
    );
  }

  Widget inputEmailFormComponent(AppLocalizations localizations) {
    return Container(
      margin: EdgeInsets.only(top: CustomAppDimensions.margin70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.email_address,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.sizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          SizedBox(
            height: CustomAppDimensions.sizeSmall,
          ),
          Container(
            height: CustomAppDimensions.heightContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_email.svg',
                    width: 17,
                  ),
                  const SizedBox(width: 16),
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
      margin: EdgeInsets.only(top: CustomAppDimensions.margin20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.password,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.sizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          SizedBox(
            height: CustomAppDimensions.sizeSmall,
          ),
          Container(
            height: CustomAppDimensions.heightContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: CustomAppTheme.kRaisinBlack,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_password.svg',
                    width: 18,
                  ),
                  const SizedBox(width: 16),
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
          )
        ],
      ),
    );
  }

  Widget signInButton(String textButton) {
    return Container(
      width: double.infinity,
      height: CustomAppDimensions.heightContainer,
      margin: EdgeInsets.only(
        top: CustomAppDimensions.defaultMargin,
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: CustomAppTheme.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          textButton,
          style: CustomTextTheme.primaryTextStyle.copyWith(
            fontSize: CustomAppDimensions.sizeLarge,
            fontWeight: CustomTextTheme.medium
          ),
        ),
      ),
    );
  }
}
