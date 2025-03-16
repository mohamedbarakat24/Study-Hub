import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/chat_bot/logic/chat_bot/chat_bot_cubit.dart';
import 'package:untitled/chat_bot/presentation/theme/font_helper.dart';
import 'package:untitled/constants/colors.dart';

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({super.key});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _buttonKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatBotCubit = BlocProvider.of<ChatBotCubit>(context);
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.r),
          borderSide:
              chatBotCubit.selectedImage != null
                  ? BorderSide(color: Colors.transparent)
                  : BorderSide(color: Colors.grey, width: 0.50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.r),
          borderSide:
              chatBotCubit.selectedImage != null
                  ? BorderSide(color: Colors.transparent)
                  : BorderSide(color: Colors.grey, width: 0.75),
        ),
        contentPadding:
            _controller.text.length <= 20
                ? EdgeInsets.symmetric(vertical: 18.h)
                : EdgeInsets.symmetric(vertical: 20.h),
        hintText: "Ask Gemini",
        hintStyle: FontHelper.fontText(16.sp, FontWeight.normal, Colors.grey),
        prefixIcon: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          splashColor: Colors.grey.shade800,
          key: _buttonKey,
          onTap: () async {
            final RenderBox renderBox =
                _buttonKey.currentContext!.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);
            final double menuY = offset.dy - renderBox.size.height - 80;

            showUploadMenu(context, Offset(offset.dx, menuY), (selected) {
              // Handle the selection
              if (selected == 'camera') {
                chatBotCubit.pickImage(true);
              } else {
                chatBotCubit.pickImage(false);
              }
            });
          },
          child: Icon(Icons.add, color: Colors.grey.shade400, size: 22.sp),
        ),
        suffixIcon: ElevatedButton(
          onPressed:
              _controller.text.isEmpty
                  ? () {}
                  : () {
                    chatBotCubit.sendMessage(_controller.text);
                    _controller.clear();
                    _scrollToBottom();
                    if (chatBotCubit.selectedImage != null) {
                      chatBotCubit.deletePickedUpImage();
                    }
                  },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            shape: CircleBorder(),
            elevation: 0,
            foregroundColor: Colors.blueGrey,
            padding: EdgeInsets.all(0),
          ),
          child: Icon(
            Icons.send,
            color: _controller.text.isEmpty ? Colors.grey : Colors.white,
            size: 18.sp,
          ),
        ),
      ),
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          chatBotCubit.sendMessage(value);
          _controller.clear();
          _scrollToBottom();
          if (chatBotCubit.selectedImage != null) {
            chatBotCubit.deletePickedUpImage();
          }
        }
      },
      style: FontHelper.fontText(
        16.sp,
        FontWeight.normal,
        MyColors.textPrimary,
      ),
      controller: _controller,
      // autofocus: true,
      maxLines: 3,
      minLines: 1,
      cursorColor: Colors.white,
    );
  }
}

void showUploadMenu(
  BuildContext context,
  Offset position,
  Function(String) onSelect,
) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx + 1,
      position.dy + 1,
    ),
    color: Colors.grey.shade900,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      side: BorderSide(color: Colors.transparent),
    ),
    items: [
      PopupMenuItem(
        value: 'camera',
        child: Row(
          children: [
            Icon(CupertinoIcons.camera, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Camera',
              style: FontHelper.fontText(
                16.sp,
                FontWeight.normal,
                Colors.white,
              ),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'gallery',
        child: Row(
          children: [
            Icon(CupertinoIcons.photo, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              'Gallery',
              style: FontHelper.fontText(
                16.sp,
                FontWeight.normal,
                Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  ).then((value) {
    if (value != null) {
      onSelect(value);
    }
  });
}
