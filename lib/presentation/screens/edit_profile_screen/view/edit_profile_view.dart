import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/helper/utils/error_mapper.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:shamoapps/presentation/widgets/dialog_loading.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: headerEditProfile(context, localizations),
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      body: SafeArea(
        child: contentProfile(context, localizations),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget headerEditProfile(
      BuildContext context, AppLocalizations localizations) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close, color: CustomAppTheme.kGhostWhite),
      ),
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        localizations.edit_profile,
        style: CustomTextTheme.primaryTextStyle.copyWith(
          fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.check,
            color: CustomAppTheme.kPrimaryColor,
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(
        right: CustomAppDimensions.kSizeMediumSemiMedium,
      ),
    );
  }

  Widget contentProfile(BuildContext context, AppLocalizations localization) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: CustomAppDimensions.kSize30,
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
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listenWhen: (prev, curr) =>
            curr is EditProfileLoading ||
            curr is EditProfileLoaded ||
            curr is EditProfileSubmitSuccess ||
            curr is EditProfileFailed,
        listener: (context, state) {
          if (state is EditProfileLoading) {
            DialogLoading.show(context);
          } else if (DialogLoading.isLoading) {
            DialogLoading.hide(context);
          }

          if (state is EditProfileLoaded) {
            nameController.text = state.user.name ?? '';
            usernameController.text = state.user.username ?? '';
            emailController.text = state.user.email ?? '';
            phoneController.text = state.user.phone ?? '';
          } else if (state is EditProfileSubmitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: CustomTextTheme.primaryTextStyle.copyWith(
                    fontSize: CustomAppDimensions.kSizeMedium,
                  ),
                ),
                backgroundColor: CustomAppTheme.kPrimaryColor,
              ),
            );
          } else if (state is EditProfileFailed) {
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
        buildWhen: (prev, curr) =>
            curr is EditProfileLoading ||
            curr is EditProfileLoaded ||
            curr is EditProfileFormValidation,
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return const SizedBox.shrink();
          }

          final validation = state is EditProfileFormValidation ? state : null;

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: CustomAppDimensions.kSize30),
                ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    width: CustomAppDimensions.kSize100,
                    height: CustomAppDimensions.kSize100,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputField(
                        context,
                        localization.name,
                        localization.name_username,
                        validation?.nameError,
                        nameController,
                        (value) => context.read<EditProfileBloc>().add(
                              EditProfileNameChanged(name: value),
                            ),
                      ),
                      inputField(
                        context,
                        localization.username,
                        localization.name_username,
                        validation?.usernameError,
                        usernameController,
                        (value) => context.read<EditProfileBloc>().add(
                              EditProfileUsernameChanged(username: value),
                            ),
                      ),
                      inputField(
                        context,
                        localization.email_address,
                        localization.hint_email_address,
                        validation?.emailError,
                        emailController,
                        (value) => context.read<EditProfileBloc>().add(
                              EditProfileEmailChanged(email: value),
                            ),
                      ),
                      inputField(
                        context,
                        localization.phone_number,
                        localization.hint_phone_number,
                        validation?.phoneError,
                        phoneController,
                        (value) => context.read<EditProfileBloc>().add(
                              EditProfilePhoneChanged(phone: value),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget inputField(
      BuildContext context,
      String label,
      String hintTxt,
      String? errorText,
      TextEditingController controller,
      void Function(String)? onChanged) {
    return Container(
      margin: const EdgeInsets.only(
        top: CustomAppDimensions.kSize30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: CustomTextTheme.secondaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeMediumSmall,
            ),
          ),
          TextFormField(
            controller: controller,
            cursorColor: CustomAppTheme.kAntiFlashWhite,
            onChanged: onChanged,
            style: CustomTextTheme.primaryTextStyle.copyWith(
              fontSize: CustomAppDimensions.kSizeLarge,
            ),
            decoration: InputDecoration(
              hintText: hintTxt,
              hintStyle: CustomTextTheme.jetTextStyle.copyWith(
                fontSize: CustomAppDimensions.kSizeLarge,
              ),
              focusedBorder: onBorderSide(),
              enabledBorder: onBorderSide(),
              errorText: ErrorMapper.map(context, errorText),
            ),
          ),
        ],
      ),
    );
  }

  UnderlineInputBorder onBorderSide() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(
        color: CustomAppTheme.kJet,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
