import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class SendButtonWidget extends StatelessWidget {
  const SendButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: CustomAppDimensions.kSize45,
        height: CustomAppDimensions.kSize45,
        decoration: BoxDecoration(
          color: CustomAppTheme.kPrimaryColor,
          borderRadius: BorderRadius.circular(
            CustomAppDimensions.kSizeSmall,
          ),
        ),
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}
