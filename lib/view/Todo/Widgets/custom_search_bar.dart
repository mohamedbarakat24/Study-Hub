import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/utils/helpers/helper_functions.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = MyHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: dark ? Colors.white54 : Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        onChanged: (value) => onSearch(value),
        cursorColor: MyColors.primary.withOpacity(0.6),
        style: TextStyle(
          color: MyColors.primary,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            Icons.search,
            color: MyColors.primary,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: MyColors.primary),
        ),
      ),
    );
  }
}
