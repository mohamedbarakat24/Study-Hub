import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/colors.dart';

class MyShadowStyle {
  static final verticalProductShadow = BoxShadow(
      color: MyColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));

  static final HorizontalProductShadow = BoxShadow(
      color: MyColors.darkGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
