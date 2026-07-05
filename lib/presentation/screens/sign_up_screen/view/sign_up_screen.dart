import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/di/service_locator.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/presentation/screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:shamoapps/presentation/widgets/dialog_loading.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => sl<SignUpBloc>(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            DialogLoading.show(context);
          } else if (DialogLoading.isLoading) {
            DialogLoading.hide(context);
          }

          if (state is SignUpSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                  ),
                ),
                backgroundColor: CustomAppTheme.kAlertColor,
              ),
            );
          }
        },
        child: Scaffold(
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
                      padding: const EdgeInsets.only(
                          bottom: CustomAppDimensions.kSize30),
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
                          inputPhoneFormComponent(localizations),
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
        ),
      ),
    );
  }

  Widget header(String title) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize30),
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
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
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
                      controller: _nameController,
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_full_name,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      cursorColor: CustomAppTheme.kGhostWhite,
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
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
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
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      controller: _usernameController,
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_username,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      cursorColor: CustomAppTheme.kGhostWhite,
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
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
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
                      controller: _emailController,
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_email_address,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      cursorColor: CustomAppTheme.kGhostWhite,
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

  Widget inputPhoneFormComponent(AppLocalizations localizations) {
    return Container(
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.phone_number,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
              fontWeight: CustomTextTheme.medium,
            ),
          ),
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
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
                  const Icon(Icons.phone,
                      color: CustomAppTheme.kPrimaryColor,
                      size: CustomAppDimensions.kSizeLarge),
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      style: CustomTextTheme.primaryTextStyle,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_phone_number,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      cursorColor: CustomAppTheme.kGhostWhite,
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
          const SizedBox(height: CustomAppDimensions.kSizeSmall),
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
                  const SizedBox(width: CustomAppDimensions.kSizeLarge),
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      style: CustomTextTheme.primaryTextStyle,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: localizations.hint_password,
                        hintStyle: CustomTextTheme.subtitleTextStyle,
                      ),
                      cursorColor: CustomAppTheme.kGhostWhite,
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
      margin: const EdgeInsets.only(top: CustomAppDimensions.kSize30),
      child: Builder(
        builder: (ctx) => TextButton(
          onPressed: () {
            ctx.read<SignUpBloc>().add(SignUpSubmitted(
                  name: _nameController.text,
                  email: _emailController.text,
                  username: _usernameController.text,
                  password: _passwordController.text,
                  phone: _phoneController.text,
                ));
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
      ),
    );
  }
}
