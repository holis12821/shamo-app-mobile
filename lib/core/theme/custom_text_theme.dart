import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_app_theme.dart';

// This uses the MaterialBasedCupertino ThemeData Mechanism so that
// we have one base text theme for both Material and Cupertino widgets

class CustomTextTheme {

  static var primaryTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kAntiFlashWhite,
  );

  static var secondaryTextStyle =
      GoogleFonts.poppins(color: CustomAppTheme.kSecondaryColor);

  static var priceTextStyle = GoogleFonts.poppins(color: CustomAppTheme.kDodgerBlue);

  static var subtitleTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kDavysGray,
  );

  static var purpleTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kPrimaryColor 
  );

  static var jetTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kJet
  );

  static var raisinBlackTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kRaisinBlack
  );
  
  static var ghostWhiteTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kGhostWhite
  );

  static var spaceCadetTextStyle = GoogleFonts.poppins(
    color: CustomAppTheme.kSpaceCadet
  );

  static var light = FontWeight.w300;
  static var regular = FontWeight.w400;
  static var medium = FontWeight.w500;
  static var semiBold = FontWeight.w600;
  static var bold = FontWeight.w700;
}
