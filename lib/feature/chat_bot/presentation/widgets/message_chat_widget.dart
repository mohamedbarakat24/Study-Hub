import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled/chat_bot/data/models/message_model.dart';
import 'package:untitled/chat_bot/presentation/theme/font_helper.dart';

class MessageChatWidget extends StatefulWidget {
  final MessageModel message;
  final ScrollController scrollController;
  final bool textAnemated;
  const MessageChatWidget({
    super.key,
    required this.message,
    required this.scrollController,
    this.textAnemated = false,
  });

  @override
  State<MessageChatWidget> createState() => _MessageChatWidgetState();
}

class _MessageChatWidgetState extends State<MessageChatWidget> {
  bool isShowAnimatedText = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final formatedDate =
        (DateTime.now().day == DateTime.parse(widget.message.time).day &&
                DateTime.now().month ==
                    DateTime.parse(widget.message.time).month &&
                DateTime.now().year == DateTime.parse(widget.message.time).year)
            ? DateFormat.jm().format(DateTime.parse(widget.message.time))
            : DateFormat.yMd().format(DateTime.parse(widget.message.time));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: double.infinity),
        widget.message.image != null
            ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.file(widget.message.image!, height: 250),
              ),
            )
            : SizedBox.shrink(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.message.isUser == true
                ? const SizedBox.shrink()
                : Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/images/gemini-color.svg',
                      height: 18.h,
                    ),
                  ),
                ),
            Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.75.w),
              margin: const EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color:
                    widget.message.isUser == true
                        ? Colors.grey.shade800
                        : Colors.grey.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                  bottomLeft:
                      widget.message.isUser == false
                          ? Radius.circular(3.r)
                          : Radius.circular(25.r),
                  bottomRight:
                      widget.message.isUser == false
                          ? Radius.circular(25.r)
                          : Radius.circular(3.r),
                ),
              ),
              child:
                  widget.message.isUser == true
                      ? Text(
                        widget.message.message,
                        style: FontHelper.fontText(
                          16.sp,
                          FontWeight.w500,
                          Colors.white,
                        ),
                      )
                      : (widget.textAnemated && isShowAnimatedText == true)
                      ? AnimatedTextKit(
                        key: ValueKey(widget.message.message),
                        animatedTexts: [
                          TypewriterAnimatedText(
                            widget.message.message,
                            textStyle: FontHelper.fontText(
                              16.sp,
                              FontWeight.w500,
                              Colors.white,
                            ),
                            speed: const Duration(milliseconds: 15),
                          ),
                        ],
                        totalRepeatCount: 1,
                        onFinished: () {
                          widget.scrollController.jumpTo(
                            widget.scrollController.position.maxScrollExtent,
                          );
                          setState(() {
                            isShowAnimatedText = false;
                            debugPrint('✅✅✅✅ ==$isShowAnimatedText');
                          });
                        },
                      )
                      : Text(
                        widget.message.message,
                        style: FontHelper.fontText(
                          16.sp,
                          FontWeight.w500,
                          Colors.white,
                        ),
                      ),
            ),
            widget.message.isUser == false
                ? const SizedBox.shrink()
                : Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Icon(CupertinoIcons.person_fill, color: Colors.white),
                ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Align(
            alignment:
                widget.message.isUser == false
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
            child: Text(
              formatedDate,
              style: FontHelper.fontText(
                12.sp,
                FontWeight.normal,
                Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
