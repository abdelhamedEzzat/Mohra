import 'package:flutter/material.dart';

class TypeDevice extends StatelessWidget {
  const TypeDevice(
      {super.key,
      required this.isMobile,
      required this.isTablet,
      required this.mediaQueryData});
  final Widget isMobile;
  final Widget isTablet;
  final MediaQueryData mediaQueryData;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = mediaQueryData.orientation;
    double width = 0;
    if (orientation == Orientation.landscape) {
      width = mediaQueryData.size.height + 1;
    } else {
      width = mediaQueryData.size.width;
    }

    if (width >= 800) {
      print("isTablet");
      return isTablet;
    } else {
      print("isMobile");
      return isMobile;
    }
  }
}
