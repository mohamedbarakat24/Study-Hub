import 'package:flutter/material.dart';

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
