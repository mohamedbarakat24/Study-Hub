import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:study_hub/feature/chat_bot/presentation/pages/home_page.dart';
import 'package:study_hub/home.dart';
import 'core/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return

        // GetMaterialApp(
        //   title: "Study Hub",
        //   themeMode: ThemeMode.system,
        //   theme: TAppTheme.lightTheme,
        //   darkTheme: TAppTheme.darkTheme,
        //   debugShowCheckedModeBanner: false,
        //   home: Home(),
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
        //);

        ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ChatGeminiHomePage(),
        );
      },
    );
  }
}
