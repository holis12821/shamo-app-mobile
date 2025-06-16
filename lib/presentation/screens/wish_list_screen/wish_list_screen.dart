import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Wish List Screen', style: TextStyle(
          color: CustomAppTheme.kAntiFlashWhite,
          fontSize: CustomAppDimensions.kSize18
        ),),
    );
  }
}