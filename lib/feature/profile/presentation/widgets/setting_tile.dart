import 'package:flutter/material.dart';
import 'package:study_hub/core/constants/colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: MyColors.buttonPrimary),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          trailing: trailing ??
              const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(indent: 20, endIndent: 20, thickness: 2),
      ],
    );
  }
}
