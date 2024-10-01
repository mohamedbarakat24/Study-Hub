import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class MyAppBarTheme {
  MyAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: MyColors.black, size: MySizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: MyColors.black, size: MySizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: MyColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: MyColors.black, size: MySizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: MyColors.white, size: MySizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: MyColors.white),
  );
}
