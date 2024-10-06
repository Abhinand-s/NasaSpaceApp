//import 'package:agri/agri.dart';
import 'package:agri/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:agri/homescreen.dart';


//import 'package:firebase_core/firebase_core.dart'; // Firebase core package
//import 'package:agri/pages/selection.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized(); // Ensures binding before Firebase initialization
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Agri App',
      home: SplashScreen(),
    );
  }
}
