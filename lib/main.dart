import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/spalsh.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        Login.routeName: (context) => const Login(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
