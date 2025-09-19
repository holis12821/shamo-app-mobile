import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultWidth;
  static late double defaultHeight;

  static void init(BuildContext context,
      {double designWidth = 375.0, double designHeight = 812.0}) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    defaultWidth = designWidth;
    defaultHeight = designHeight;
  }

  static double width({required double designWidthPx}) {
    return (designWidthPx / defaultWidth) * screenWidth;
  }

  static double height({required double designHeightPx}) {
    return (designHeightPx / defaultHeight) * screenHeight;
  }
}
