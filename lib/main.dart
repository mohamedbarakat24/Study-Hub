import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:study_hub/app.dart';
// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const App(),
    ),
  );
}
