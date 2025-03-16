import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/constants/colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.black,
      backgroundColor: MyColors.buttonPrimary,
      shadowColor: Colors.grey.shade900,
      scrolledUnderElevation: 0,
      elevation: 0,

      title: SvgPicture.asset(
        'assets/images/gemini-brand.svg',
        height: 30.h,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),

      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
