import 'package:flutter/material.dart';

class ResponsiveUtility {
  static const maxMobileWidth = 510;

  static bool isBiggerThanMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    debugPrint('current viewport width: $width');
    return width > maxMobileWidth;
  }
}
