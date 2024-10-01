import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/utils/helpers/helper_functions.dart';

class AddToDoBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddPressed;

  const AddToDoBar({
    Key? key,
    required this.controller,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dark ? Colors.white54 : Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                cursorColor: MyColors.primary.withOpacity(0.6),
                style: const TextStyle(
                  color: MyColors.primary,
                  fontSize: 17,
                ),
                decoration: const InputDecoration(
                  hintText: 'Add a new todo item.',
                  hintStyle: TextStyle(color: MyColors.primary),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.MyBesto,
                elevation: 7,
                minimumSize: const Size(60, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onAddPressed,
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
