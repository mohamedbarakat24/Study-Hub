import 'package:flutter/material.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Icon(Icons.menu, size: 35, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      buildListTile(
                        title: "Take notes",
                        icon: Icons.note_add_outlined,
                        function: () {
                          print("Take notes tapped!");
                        },
                      ),
                      buildListTile(
                        title: "PDF Tools",
                        icon: Icons.picture_as_pdf_outlined,
                        function: () {
                          print("PDF Tools tapped");
                        },
                      ),
                      buildListTile(
                        title: "Profile",
                        icon: Icons.person,
                        function: () {
                          print("Profile tapped");
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      buildListTile(
                        title: "Settings",
                        icon: Icons.settings,
                        function: () {
                          print("Settings");
                        },
                      ),
                      buildListTile(
                        title: "Logout",
                        icon: Icons.logout,
                        function: () {
                          print("Logout");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Screen'),
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback function,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Icon(
          icon,
          size: 30,
        ),
        onTap: function, // Correctly Call the function here
      ),
    );
  }
}
