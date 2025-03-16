import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/chat_bot/logic/chat_bot/chat_bot_cubit.dart';

class PickedImage extends StatelessWidget {
  const PickedImage({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBotCubit = BlocProvider.of<ChatBotCubit>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(chatBotCubit.selectedImage!, height: 70.h),
          ),
          Positioned(
            top: 3.h,
            right: 3.w,
            child: InkWell(
              onTap: () {
                chatBotCubit.deletePickedUpImage();
              },
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(0, 1),
                      blurRadius: 10.0,
                      spreadRadius: 3.0,
                    ),
                  ],
                  border: Border.all(color: Colors.black45, width: 0.75),
                ),
                child: Icon(Icons.clear, size: 19.r),
              ),
            ),
          ),
          // ElevatedButton(
          //     style: ButtonStyle(
          //         padding: WidgetStateProperty.all(EdgeInsets.zero),
          //         shape: WidgetStateProperty.all(CircleBorder()),
          //         side: WidgetStatePropertyAll(BorderSide())),
          //     onPressed: () {},
          //     child: Icon(
          //       Icons.clear,
          //       color: Colors.black,
          //       size: 18.r,
          //     )))
        ],
      ),
    );
  }
}
