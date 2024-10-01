import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class MyOutlinedButtonTheme {
  MyOutlinedButtonTheme._(); //To avoid creating instances


  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: MyColors.dark,
      side: const BorderSide(color: MyColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: MyColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MySizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MySizes.buttonRadius)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: MyColors.light,
      side: const BorderSide(color: MyColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: MyColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MySizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MySizes.buttonRadius)),
    ),
  );
}
