import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/chat_bot/logic/chat_bot/chat_bot_cubit.dart';
import 'package:untitled/chat_bot/presentation/widgets/my_text_form_field.dart';
import 'package:untitled/chat_bot/presentation/widgets/picked_image.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBotCubit = BlocProvider.of<ChatBotCubit>(context);

    return SafeArea(
      child: BlocBuilder<ChatBotCubit, ChatBotState>(
        bloc: chatBotCubit,
        buildWhen:
            (previous, current) =>
                current is PickedImageSucces || current is DeletePickedUpImage,
        builder: (context, state) {
          if (state is PickedImageSucces) {
            return Container(
              height: 160.h,
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [PickedImage(), Expanded(child: MyTextFormField())],
              ),
            );
          } else {
            return Container(
              height: 65.h,
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Expanded(child: MyTextFormField())],
              ),
            );
          }
        },
      ),
    );
  }
}
