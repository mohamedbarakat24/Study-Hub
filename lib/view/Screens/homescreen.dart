import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/view/Screens/OCR_screen/ocr_img_screen.dart';
import 'package:study_hub/view/Screens/Ocr_PDF/ocr_pdf.dart';
import 'package:study_hub/view/components/drawer.dart';
import 'package:study_hub/view/chatview/chat_view.dart';

import 'summarize_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    Center(child: OCRImgScreen()),
    Center(child: ChatView()),
    Center(child: OcrPdfScreen()),
    Center(child: MenuDrawer()),
    Center(child: SummarizeScreen()),
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
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'H',
                ),
                GButton(
                  icon: Icons.chat,
                  text: 'Ch',
                ),
                GButton(
                  icon: Icons.check_box,
                  text: 'To',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'd',
                ),
                GButton(
                  icon: Icons.home,
                  text: 's',
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
        ),
      ),
    );
  }
}
