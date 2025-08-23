import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class DialogLoading {
  static var isLoading = false;
  static void show(BuildContext context) {
    isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(CustomAppTheme.kAntiFlashWhite),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    isLoading = false;
    Navigator.of(context, rootNavigator: true).pop();
  }
}
