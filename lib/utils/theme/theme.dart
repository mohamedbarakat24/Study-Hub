import 'package:flutter/material.dart';
import 'package:study_hub/utils/theme/widget_themes/appbar_theme.dart';
import 'package:study_hub/utils/theme/widget_themes/chip_theme.dart';
import 'package:study_hub/utils/theme/widget_themes/text_field_theme.dart';
import 'package:study_hub/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';
import 'widget_themes/checkbox_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: MyColors.grey,
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 83, 145, 226),
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 83, 147, 226)),
    textTheme: MyTextTheme.lightTextTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    scaffoldBackgroundColor: MyColors.white,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyCheckboxTheme.lightCheckboxTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: MyColors.grey,
    brightness: Brightness.dark,
    primaryColor: MyColors.primary,
    textTheme: MyTextTheme.darkTextTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    scaffoldBackgroundColor: MyColors.black,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    checkboxTheme: MyCheckboxTheme.darkCheckboxTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
  );
}
