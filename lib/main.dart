import 'package:flutter/material.dart';
//Import other pages
import 'package:test1/screens/profile.dart';

void main() {
  runApp(
    MaterialApp(
      //Light theme
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      //Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.black,
          ),
        ),
      ),

      //check what theme system uses
      themeMode: ThemeMode.system,

      //Application
      home: const Profile()
    ),
  );
}
