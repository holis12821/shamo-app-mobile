import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(CustomAppDimensions.kSize20),
      ),
      child: BottomAppBar(
        height: CustomAppDimensions.kSize60,
        elevation: 0,
        color: CustomAppTheme.kRaisinBlackLight,
        shape: const CircularNotchedRectangle(),
        notchMargin: CustomAppDimensions.kSize10,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/ic_home.svg',
                    width: CustomAppDimensions.kSize20,
                    height: CustomAppDimensions.kSize20,
                  ),
                ),
                const SizedBox(width: CustomAppDimensions.kSize18),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/ic_chat.svg',
                    width: CustomAppDimensions.kSize20,
                    height: CustomAppDimensions.kSize20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/ic_wishlist.svg',
                    width: CustomAppDimensions.kSize20,
                    height: CustomAppDimensions.kSize20,
                  ),
                ),
                const SizedBox(width: CustomAppDimensions.kSize18),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/ic_profile_grey.svg',
                    width: CustomAppDimensions.kSize18,
                    height: CustomAppDimensions.kSize18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
