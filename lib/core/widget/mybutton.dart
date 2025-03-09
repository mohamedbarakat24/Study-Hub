import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.lable, required this.onTap});

  final String lable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.primaryClr),
        width: 100,
        height: 45,
        alignment: Alignment.center,
        child: Text(
          lable,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
