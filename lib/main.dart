import 'package:flutter/material.dart';
import 'package:study_hub/app.dart';
import 'package:study_hub/feature/noteApp/data/models/note_database.dart';

import 'package:provider/provider.dart';
import 'core/db/db_hellper.dart';
// void main() {
//   runApp(const MyApp());
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DbHelper.initDb();
//   // await Firebase.initializeApp(
//   //   options: DefaultFirebaseOptions.currentPlatform,
//   // );
//   runApp(
//     const App(),
//   );

// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  await DbHelper.initDb();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NoteDatabase())],
      child: const App(),
    ),
  );
}
