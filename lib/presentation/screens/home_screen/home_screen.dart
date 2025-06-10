import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/presentation/widgets/custom_bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppTheme.kRaisinPrimaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartButton(),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Widget cartButton() {
    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      backgroundColor: CustomAppTheme.kSecondaryColor,
      child: SvgPicture.asset(
        CustomAssets.icCartWhite,
        width: CustomAppDimensions.kSize20,
      ),
    );
  }
}
