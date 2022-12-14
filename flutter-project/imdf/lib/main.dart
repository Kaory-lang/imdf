import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';
import 'screens/EmailAuthenticationScreen.dart';
import 'screens/MainScreen.dart';
import 'screens/AddMovieScreen.dart';
import 'screens/SelectAuthMethodScreen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDF',
      routes: {
        '/': (context) => SelectAuthMethodScreen(),
        '/signin': (context) => SigninScreen(),
        '/main': (context) => MainScreen(),
        '/add_movie': (context) => AddMovieScreen(),
      },
    );
  }
}

