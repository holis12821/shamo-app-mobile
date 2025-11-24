import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

class AddressDetailWidget extends StatelessWidget {
  const AddressDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: CustomAppDimensions.kSizeSmall,
        horizontal: CustomAppDimensions.kSizeSmall,
      ),
      padding: const EdgeInsets.all(CustomAppDimensions.kSize20),
      decoration: BoxDecoration(
        color: CustomAppTheme.kRaisinBlackLight,
        borderRadius: BorderRadius.circular(
          CustomAppDimensions.kSizeSmall,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                localizations.address_details,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontWeight: CustomTextTheme.medium,
                  fontSize: CustomAppDimensions.kSizeLarge,
                ),
              ),
              const SizedBox(height: CustomAppDimensions.kSizeSmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // Icon store
                      Container(
                        width: CustomAppDimensions.kSize40,
                        height: CustomAppDimensions.kSize40,
                        padding:
                            const EdgeInsets.all(CustomAppDimensions.kSize10),
                        decoration: const BoxDecoration(
                          color: CustomAppTheme.kGunMetal,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          CustomAssets.kIconBuilding,
                          width: CustomAppDimensions.kSizeMedium,
                        ),
                      ),
                      const SizedBox(
                        height: CustomAppDimensions.kSize30,
                        child: DottedLine(
                          direction: Axis.vertical,
                          lineLength: CustomAppDimensions.kSize30,
                          dashLength: CustomAppDimensions.kSizeSmallMedium,
                          dashGapLength: CustomAppDimensions.kSizeSmallMedium,
                          dashColor: CustomAppTheme.kTimberWolf,
                          lineThickness: CustomAppDimensions.kThicknessThin,
                        ),
                      ),
                      // Icon location
                      Container(
                        width: CustomAppDimensions.kSize40,
                        height: CustomAppDimensions.kSize40,
                        padding:
                            const EdgeInsets.all(CustomAppDimensions.kSize10),
                        decoration: const BoxDecoration(
                          color: CustomAppTheme.kGunMetal,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          CustomAssets.kIconLocation,
                          width: CustomAppDimensions.kSizeMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: CustomAppDimensions.kSizeSmall),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.store_location,
                          style: CustomTextTheme.secondaryTextStyle.copyWith(
                            fontSize: CustomAppDimensions.kSizeSmall,
                            fontWeight: CustomTextTheme.light,
                          ),
                        ),
                        const SizedBox(
                            height: CustomAppDimensions.kSizeSmallMedium),
                        Text(
                          localizations.product_name,
                          style: CustomTextTheme.primaryTextStyle.copyWith(
                            fontSize: CustomAppDimensions.kSizeMedium,
                            fontWeight: CustomTextTheme.medium,
                          ),
                        ),
                        const SizedBox(height: CustomAppDimensions.kSize30),
                        Text(
                          localizations.your_address,
                          style: CustomTextTheme.secondaryTextStyle.copyWith(
                            fontSize: CustomAppDimensions.kSizeSmall,
                            fontWeight: CustomTextTheme.light,
                          ),
                        ),
                        const SizedBox(
                            height: CustomAppDimensions.kSizeSmallMedium),
                        Text(
                          localizations.address_location,
                          style: CustomTextTheme.primaryTextStyle.copyWith(
                            fontSize: CustomAppDimensions.kSizeMedium,
                            fontWeight: CustomTextTheme.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: CustomAppDimensions.kSizeSmallMedium,
            bottom: CustomAppDimensions.kSize10,
            child: Container(
              width: CustomAppDimensions.kSizeSuperLarge,
              height: CustomAppDimensions.kSizeSuperLarge,
              decoration: BoxDecoration(
                color: CustomAppTheme.kGunMetal,
                borderRadius:
                    BorderRadius.circular(CustomAppDimensions.kSizeSmallMedium),
              ),
              child: const Icon(
                size: CustomAppDimensions.kSizeLarge,
                Icons.edit,
                color: CustomAppTheme.kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}