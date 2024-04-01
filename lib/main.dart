import 'package:flutter/material.dart';
import 'package:kinbech/intropage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intropage(),
    );

  }
}*/


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Object Detection App',
      debugShowCheckedModeBanner: false,
      // home: ObjectDetectionScreen(),
      home: Intropage(),
    );
  }
}
