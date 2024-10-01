import 'package:flutter/material.dart';
import 'package:study_hub/utils/constants/colors.dart';
import 'package:study_hub/view/Screens/OCR_screen/ocr_screen.dart';
import 'package:study_hub/view/Todo/to_doScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const Center(child: OCRScreen()),
    const Center(child: Text('Chat Bot', style: TextStyle(fontSize: 24))),
    Center(child: ToDoScreen()),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'To-Do List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.MyBesto,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }
}
