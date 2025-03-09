import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/theme.dart';
import 'home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Study Hub",
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      //     StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const SplashScreen();
      //     }
      //     if (snapshot.hasData) {
      //       final authUser = FirebaseAuth.instance.currentUser!;

      //       return HomeScreen();
      //     }
      //     return const LoginScreen();
      //   },
      // ),
    );
  }
}
