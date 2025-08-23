import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';

class CustomBottomBarWidget extends StatelessWidget {
  const CustomBottomBarWidget(
      {super.key, required this.selectedIndex, required this.onTap, required this.icons});

  final int selectedIndex;
  final List<String> icons;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final heightBottomBar = screenHeight * (60 / screenHeight);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(CustomAppDimensions.kSize20),
      ),
      child: BottomAppBar(
        height: heightBottomBar,
        elevation: 0,
        color: CustomAppTheme.kRaisinBlackLight,
        shape: const CircularNotchedRectangle(),
        notchMargin: CustomAppDimensions.kSizeSmall,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildNavItem(0),
                const SizedBox(width: CustomAppDimensions.kSize50),
                _buildNavItem(1),
              ],
            ),
            Row(
              children: [
                _buildNavItem(2),
                const SizedBox(width: CustomAppDimensions.kSize50),
                _buildNavItem(3),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildNavItem(int index) {
    final bool isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedScale(
        scale: isActive ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: isActive ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 300),
          child: SvgPicture.asset(icons[index],
            width: CustomAppDimensions.kSizeSuperLarge,
            colorFilter: ColorFilter.mode(isActive ? CustomAppTheme.kPrimaryColor : CustomAppTheme.kTaupeGray, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}