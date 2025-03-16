import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingChatMessage extends StatefulWidget {
  const LoadingChatMessage({super.key});

  @override
  State<LoadingChatMessage> createState() => _LoadingChatMessageState();
}

class _LoadingChatMessageState extends State<LoadingChatMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 8.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.grey.shade800,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset('assets/images/gemini-color.svg',
                height: 18.h),
          ),
          SizedBox(width: 8.w),
          LoadingAnimationWidget.horizontalRotatingDots(
              color: Colors.grey.shade600, size: 24.sp),
        ],
      ),
    );
  }
}
