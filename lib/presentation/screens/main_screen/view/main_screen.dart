import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/presentation/screens/chat_screen/view/chat_screen.dart';
import 'package:shamoapps/presentation/screens/home_screen/view/home_screen.dart';
import 'package:shamoapps/presentation/screens/profile_screen/view/profile_screen.dart';
import 'package:shamoapps/presentation/screens/wish_list_screen/view/wish_list_screen.dart';
import 'package:shamoapps/presentation/widgets/custom_bottom_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  final _pages = const [
    // Add your pages here
    HomeScreen(),
    ChatScreen(),
    WishListScreen(),
    ProfileScreen(),
  ];

  final List<String> _icons = [
    CustomAssets.kIconHome,
    CustomAssets.kIconChat,
    CustomAssets.kIconWishlist,
    CustomAssets.kIconProfile,
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CustomAppTheme.kRaisinPrimaryColor,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: _pages[_selectedIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartButton(),
      bottomNavigationBar: CustomBottomBarWidget(
        selectedIndex: _selectedIndex,
        onTap: _onTap,
        icons: _icons,
      ),
    );
  }

  Widget cartButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
      shape: const CircleBorder(),
      elevation: CustomAppDimensions.kSize8,
      backgroundColor: CustomAppTheme.kSecondaryMainColor,
      child: SvgPicture.asset(
        CustomAssets.kIconCartWhite,
        width: CustomAppDimensions.kSizeSuperLarge,
      ),
    );
  }
}
