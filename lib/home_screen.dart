import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:study_hub/core/constants/colors.dart';
import 'package:study_hub/feature/ocr/presentation/ocr_img_screen.dart';
import 'package:study_hub/feature/summarization/presentation/summarize_screen.dart';
import 'package:study_hub/feature/translation/presentation/translate_screen.dart';

import '../../feature/to_do/presentation/to_do_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const ToDoScreen(),
    const SummarizeScreen(),
    const OCRImgScreen(),
    const TranslateScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Hub'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              activeColor: MyColors.MyBesto,
              color: Colors.grey,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: MyColors.MyBesto.withOpacity(0.1),
              tabs: const [
                GButton(
                  icon: Icons.check_box,
                  //text: 'To',
                ),
                GButton(
                  icon: Icons.edit_document,
                  //text: 'H',
                ),
                GButton(
                  icon: Icons.chat,
                  //text: 'Ch',
                ),
                GButton(
                  icon: Icons.translate,
                  // text: 'd',
                ),
                // GButton(
                //   icon: Icons.home,
                //   // text: 's',
                // ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
