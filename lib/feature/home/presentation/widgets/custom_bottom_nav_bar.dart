import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:study_hub/core/constants/colors.dart'; // Ensure you have this package in your pubspec.yaml

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          gap: 8,
          activeColor: MyColors.buttonPrimary,
          color: Colors.grey,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey.withOpacity(0.4),
          tabs: const [
            GButton(
              icon: Icons.check_box,
              // text: 'To',
            ),
            GButton(
              icon: Icons.edit_document,
              // text: 'H',
            ),
            GButton(
              icon: Icons.chat_rounded,
              // text: 'AI',
            ),
            GButton(
              icon: Icons.person_2_outlined,
              // text: 'd',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
