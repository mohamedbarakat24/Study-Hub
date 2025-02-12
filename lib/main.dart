//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const App(),
  );
}
