import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/chat_bot/data/models/message_model.dart';
import 'package:untitled/chat_bot/logic/chat_bot/chat_bot_cubit.dart';
import 'package:untitled/chat_bot/presentation/widgets/loading_chat_message.dart';
import 'package:untitled/chat_bot/presentation/widgets/message_chat_widget.dart';

class BodyOfChatBot extends StatefulWidget {
  final List<MessageModel> messages;
  final ScrollController scrollController;

  const BodyOfChatBot({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  @override
  State<BodyOfChatBot> createState() => _BodyOfChatBotState();
}

class _BodyOfChatBotState extends State<BodyOfChatBot> {
  @override
  Widget build(BuildContext context) {
    final chatBotCubit = BlocProvider.of<ChatBotCubit>(context);
    return BlocBuilder<ChatBotCubit, ChatBotState>(
      bloc: chatBotCubit,
      buildWhen:
          (previous, current) =>
              current is SendingMessage || current is MessageSent,
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: widget.scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 4.h),
                  itemCount: widget.messages.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Align(
                      alignment:
                          widget.messages[index].isUser
                              ? Alignment.topRight
                              : Alignment.topLeft,
                      child: IntrinsicWidth(
                        child: MessageChatWidget(
                          message: widget.messages[index],
                          scrollController: widget.scrollController,
                          textAnemated:
                              (widget.messages.length - 1 == index &&
                                      state is MessageSent)
                                  ? true
                                  : false,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (state is SendingMessage)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: LoadingChatMessage(),
                ),
            ],
          ),
        );
      },
    );
  }
}
