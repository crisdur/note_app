import 'package:flutter/material.dart';

class Responsive {
  /// Calculates the responsive font size based on the base font size and the window height.
  ///
  /// The maximum font size can be specified to prevent the font size from becoming too large.
  ///
  /// * `baseFontSize` - The base font size in pixels.
  /// * `maximum` - The maximum font size in pixels.
  ///
  /// Returns the calculated font size in pixels.
  static double responsiveFontSize(double baseFontSize, double? maximum) {
    final height =
        MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
    double result = baseFontSize * (height / 844);

    if (maximum != null) {
      if (maximum < result) {
        result = maximum;
      }
    }

    return result;
  }

  /// Calculates the responsive height based on the size, minimum, and maximum values.
  ///
  /// The minimum and maximum values can be specified to prevent the height from becoming too small or too large.
  ///
  /// * `size` - The size in pixels.
  /// * `minimum` - The minimum height in pixels.
  /// * `maximum` - The maximum height in pixels.
  ///
  /// Returns the calculated height in pixels.
  static double responsiveHeight({
    required double size,
    double? minimum,
    double? maximum,
  }) {
    final height =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
    double result = (size / 844) * height;

    if (minimum != null) {
      // Handle minimum height if needed.
    }

    if (maximum != null) {
      // Handle maximum height if needed.
    }

    return result;
  }

  /// Calculates the responsive width based on the size, minimum, and maximum values.
  ///
  /// The minimum and maximum values can be specified to prevent the width from becoming too small or too large.
  ///
  /// * `size` - The size in pixels.
  /// * `minimum` - The minimum width in pixels.
  /// * `maximum` - The maximum width in pixels.
  ///
  /// Returns the calculated width in pixels.
  static double responsiveWidth({
    required double size,
    double? minimum,
    double? maximum,
  }) {
    final width =
        MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
    double result = (size / 390) * width;

    if (minimum != null) {
      // Handle minimum width if needed.
    }

    if (maximum != null) {
      // Handle maximum width if needed.
    }

    return result;
  }

  /// Checks if the current device is a mobile device.
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Checks if the current device is a tablet.
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;
  }

  /// Checks if the current device is a desktop.
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double percentageHeight(
    BuildContext context,
    double percentage, {
    double? maxHeight,
    double? minHeight,
  }) {
    final height = MediaQuery.of(context).size.height;

    if (maxHeight != null && height > maxHeight) {
      return maxHeight;
    }

    if (minHeight != null && height < minHeight) {
      return minHeight;
    }

    return (height * percentage) / 100.0;
  }

  static double percentageWidth(
    BuildContext context,
    double percentage, {
    double? maxWidth,
    double? minWidth,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (maxWidth != null && width > maxWidth) {
      return maxWidth;
    }

    if (minWidth != null && width < minWidth) {
      return minWidth;
    }

    return (width * percentage) / 100.0;
  }
}
