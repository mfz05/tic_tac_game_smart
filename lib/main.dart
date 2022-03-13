//!هذا المشروع في المجلد tic_tac_game_smart
//!هو امتداد لنفس المشروع في المجلد tic_tac_game
//!هنا سوف نستمر من حيث توقفنا هناك
//!----------------------------------------------------------------------------

//! الدرس القادم سوف نجعله في مجلد مشروع مستقل اسمه
//! tic_tac_game_responsive
//! وهو جعل التطبيق متجاوب مع الوضع الافقي

import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark, //اخترنا مظهر الثيم سوف يكون دارك
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00061a),
        shadowColor: const Color(0xFF001456),
        splashColor: const Color(0xFF4169e8),
      ),
      home: const HomePage(),
    );
  }
}
