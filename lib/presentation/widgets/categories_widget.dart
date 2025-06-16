import 'package:flutter/material.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  int selectedIndex = 0;

  void onCategorySelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<String> categories = [
    'All Shoes',
    'Running',
    'Training',
    'Basketball',
    'Hiking',
    'Casual',
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: CustomAppDimensions.kSize40,
            margin: const EdgeInsets.only(
              top: CustomAppDimensions.kSize30,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: CustomAppDimensions.kSizeMediumLarge,
                right: CustomAppDimensions.kSizeMediumLarge,
              ),
              itemBuilder: (context, index) {
                return _buildCategoryItem(localizations, index);
              },
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(AppLocalizations localizations, int index) {
    final category = categories[index];

    return GestureDetector(
      onTap: () {
        onCategorySelected(index);
      },
      child: Container(
        height: CustomAppDimensions.kSize40,
        margin: const EdgeInsets.only(
          right: CustomAppDimensions.kSize8,
          left: CustomAppDimensions.kSize8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: CustomAppDimensions.kSizeSmall,
          vertical: CustomAppDimensions.kSize10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            CustomAppDimensions.kSizeSmall,
          ),
          color: selectedIndex == index
              ? CustomAppTheme.kPrimaryColor
              : CustomAppTheme.kTransparentColor,
          border: selectedIndex == index
              ? const Border.fromBorderSide(
                  BorderSide.none,
                )
              : const Border.fromBorderSide(
                  BorderSide(
                    color: CustomAppTheme.kDavysGray,
                  ),
                ),
        ),
        child: Text(
          category,
          style: selectedIndex == index
              ? CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeMediumSmall,
                  fontWeight: CustomTextTheme.medium,
                )
              : CustomTextTheme.subtitleTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeMediumSmall,
                  fontWeight: CustomTextTheme.medium,
                ),
        ),
      ),
    );
  }
}
