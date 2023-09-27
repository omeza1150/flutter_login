import 'package:flutter/material.dart';
import 'package:flutter_login/home.dart';

import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login', // เพิ่มบรรทัดนี้เพื่อกำหนดหน้าแรก
      routes: {
        'Register': (context) => const Register(),
        'login': (context) => const Login(), // เพิ่มเส้นทางสำหรับหน้า Login
        'home': (context) => const Homepage(), // เพิ่มเส้นทางสำหรับหน้า Home
      },
    );
  }
}
