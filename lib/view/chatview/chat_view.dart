import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:study_hub/Model/ChatModel/models/message_model.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/utils/helpers/helper_functions.dart';
import 'package:study_hub/view/chatview/Style/styles.dart';
import 'package:study_hub/view/chatview/widgets/chat_bubble.dart';
import 'package:study_hub/view/chatview/widgets/custom_text_field.dart';

class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
  });

  @override
  State<ChatView> createState() => _UsersChatViewState();
}

class _UsersChatViewState extends State<ChatView> {
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  static const apiKey = "AIzaSyDUxwdKG05EZnzHcx148VJZNWcS_ocDypA";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];
  bool _isTyping = false; // Add the typing state

  Future<void> sendMessage() async {
    setState(() {
      _messages
          .add(Message(isUser: true, message: text!, date: DateTime.now()));
      _isTyping = true;
    });

    final content = [Content.text(text!)];
    final response = await model.generateContent(content);

    setState(() {
      _isTyping = false;
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });


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

  String? text;

  @override
  void dispose() {
    textEditingController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark ?MyColors.MyDarkTheme:Colors.white,
        centerTitle: true,
        title: Text(
          'Chat With Gemini',
          style: Style.font22Bold(context)
              .copyWith(color: dark ?MyColors.MyBesto:MyColors.MyBesto),
        ),
      ),
      backgroundColor: dark? MyColors.MyDarkTheme:const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SafeArea(
              child: SizedBox(),
            ),
            Expanded(
              child: ListView.builder(
                reverse: false,
                controller: _scrollController,
                itemCount: _messages.length +
                    1, // Adjust item count to add typing indicator
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    // Show typing indicator at the bottom
                    return _isTyping
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Gemini is typing...",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(); // If not typing, show nothing
                  }
                  return _messages[index].isUser
                      ? ChatWidgetBubble(
                          msg: _messages[index].message,
                          date: _messages[index].date,
                        )
                      : ChatWidgetBubblefriend(
                          date: _messages[index].date,
                          msg: _messages[index].message,
                        );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: dark ?MyColors.MyDarkTheme:Colors.white,
              child: Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      onFieldSubmitted: (msg) {},
                      focusNode: _focusNode,
                      hintTitle: 'Send a chat message',
                      textEditingController: textEditingController,
                      obscure: false,
                      onSubmit: (value) {
                        text = value;
                        setState(() {});
                      },
                      isPassword: false,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: text == null || text == ''
                            ? null
                            : () {
                                textEditingController.clear();
                                sendMessage();
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                                _focusNode.unfocus();
                                text = '';
                              },
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          color: text == null || text == ''
                              ? Colors.grey
                              :  MyColors.MyBesto,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _messages.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color:MyColors.MyBesto,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
