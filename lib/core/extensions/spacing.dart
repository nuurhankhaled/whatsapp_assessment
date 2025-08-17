import 'package:flutter/material.dart';

extension SpacingExtensions on BuildContext {
  SizedBox verticalSpace(double height) {
    return SizedBox(height: height);
  }

  SizedBox horizontalSpace(double width) {
    return SizedBox(width: width);
  }
}
