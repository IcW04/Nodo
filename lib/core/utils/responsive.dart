import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double contentMaxWidth(BuildContext context) {
    final w = screenWidth(context);
    if (w > 1200) return 1100;
    if (w > 768) return w * 0.9;
    return w;
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.symmetric(horizontal: 20);
    if (isTablet(context)) return const EdgeInsets.symmetric(horizontal: 48);
    return const EdgeInsets.symmetric(horizontal: 80);
  }
}
