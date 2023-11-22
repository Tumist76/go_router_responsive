import 'package:flutter/material.dart';

class ResponsiveUtility {
  static const mobile = 510;

  static bool isBiggerThanMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print('current width: $width');
    return width > mobile;
  }

  static Size getScreenSize(BuildContext context) {
    final screenSize = View.of(context).physicalSize;
    final pixelRatio = View.of(context).devicePixelRatio;
    return Size(
      screenSize.width / pixelRatio,
      screenSize.height / pixelRatio,
    );
  }
}
