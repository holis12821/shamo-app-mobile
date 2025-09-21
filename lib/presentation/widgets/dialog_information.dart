import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shamoapps/core/theme/custom_app_dimensions.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/core/theme/custom_assets.dart';
import 'package:shamoapps/core/theme/custom_text_theme.dart';
import 'package:shamoapps/helper/utils/size_config/size_config.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';

Future<void> showDialogInformation(BuildContext context) async {
  SizeConfig.init(context);
  var localizations = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (BuildContext context) => SizedBox(
      width: SizeConfig.widthTimesMargin(
          designWidthPx: CustomAppDimensions.kSize30),
      child: AlertDialog(
        backgroundColor: CustomAppTheme.kRaisinBlackSecond,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomAppDimensions.kSize30),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: CustomAppTheme.kAntiFlashWhite,
                  ),
                ),
              ),
              SvgPicture.asset(
                CustomAssets.kIconCheckList,
                width: CustomAppDimensions.kSize100,
                height: CustomAppDimensions.kSize100,
              ),
              const SizedBox(height: CustomAppDimensions.kSizeSmall),
              Text(
                localizations.wording_dialog_information,
                style: CustomTextTheme.primaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeMediumSemiMedium,
                  fontWeight: CustomTextTheme.semiBold,
                ),
              ),
              const SizedBox(height: CustomAppDimensions.kSizeSmall),
              Text(
                localizations.item_added_successfully,
                textAlign: TextAlign.center,
                style: CustomTextTheme.secondaryTextStyle.copyWith(
                  fontSize: CustomAppDimensions.kSizeMedium,
                  fontWeight: CustomTextTheme.regular,
                ),
              ),
              const SizedBox(height: CustomAppDimensions.kSize20),
              SizedBox(
                width: CustomAppDimensions.kSize154,
                height: CustomAppDimensions.kSize44,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: CustomAppTheme.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CustomAppDimensions.kSizeSmall),
                    ),
                  ),
                  child: Text(
                    localizations.view_my_cart,
                    style: CustomTextTheme.primaryTextStyle.copyWith(
                      fontSize: CustomAppDimensions.kSizeLarge,
                      fontWeight: CustomTextTheme.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
