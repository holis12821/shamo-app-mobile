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
  final localizations = AppLocalizations.of(context)!;

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
                padding: const EdgeInsets.only(bottom: CustomAppDimensions.kSize20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(localizations.login),
                   const SizedBox(height: CustomAppDimensions.kSizeSuperSmall),
                    Text(
                      localizations.sign_in_to_continue,
                      style: CustomTextTheme.subtitleTextStyle,
                    ),
                    inputEmailFormComponent(localizations),
                    inputPasswordFormComponent(localizations),
                    signInButton(context, localizations.txt_sign_in),
                  ],
                ),
              ),
            ),
            footer(context, localizations), // Always appears, but can scroll when landscape
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
            localizations.txt_footer,
            style: CustomTextTheme.subtitleTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeSmall,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/sign-up'),
            child: Text(
              localizations.txt_sign_up,
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

  Widget inputEmailFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize70),
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
                  BorderRadius.circular(CustomAppDimensions.kSizeSmall),
            ),
            child: Center(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_email.svg',
                    width: CustomAppDimensions.kSize17,
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
            padding:
                const EdgeInsets.symmetric(horizontal: CustomAppDimensions.kSizeLarge),
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
                    width: CustomAppDimensions.kSize18,
                  ),
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_password,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
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

  Widget signInButton(BuildContext context, String textButton) {
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
            borderRadius: BorderRadius.circular(CustomAppDimensions.kSizeSmall),
          ),
        ),
        child: Text(
          textButton,
          style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium),
        ),
      ),
    );
  }
}
