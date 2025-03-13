import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/feature/profile/presentation/screens/policy_screen.dart';
import 'package:study_hub/feature/profile/presentation/widgets/header.dart';
import 'package:study_hub/feature/profile/presentation/widgets/setting_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SectionTitle(title: "Account Settings"),
            SettingsTile(
              icon: Icons.location_on,
              title: "Address",
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.payment,
              title: "Payment Method",
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.notifications,
              title: "Notification",
              onTap: () {},
            ),
            const SectionTitle(title: "General"),
            SettingsTile(
              icon: Icons.person_add,
              title: "Invite Friends",
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                );
              },
            ),
            SettingsTile(icon: Icons.help, title: "Help Center", onTap: () {}),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text("Logout", style: TextStyle(color: Colors.red)),
      onTap: () {
        FirebaseAuth.instance.signOut();
      },
    );
  }
}
