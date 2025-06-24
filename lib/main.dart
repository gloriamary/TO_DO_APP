import 'package:flutter/material.dart';
import 'package:todo/Presentation/screen_home.dart';
import 'package:todo/Presentation/splash_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenSplash(),
    );
  }
}
