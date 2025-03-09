import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/size_config.dart';
import '../theme/theme.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            width: SizeConfig.screenWidth,
            height: 52,
            // alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    autofocus: false,
                    style: subTitleStyle,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey,
                    readOnly: widget != null ? true : false,
                    decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0),
                        ),
                        hintText: hint,
                        hintStyle: subTitleStyle),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
