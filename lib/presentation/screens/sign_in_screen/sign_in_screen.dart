import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.kGhostWhite,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: CustomAppDimensions.defaultMargin,
          ),
          child: Column(
            children: [
              header()
            ],
          ),
        ),
      ),
    );
  }

  Widget header() => Container(
        margin: EdgeInsets.only(
          top: CustomAppDimensions.defaultMargin,
        ),
        child: const Text(
          ''
        ),
      );
}
