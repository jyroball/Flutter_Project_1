import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Import other pages
import 'add_user/bloc/add_user_bloc.dart';
import 'package:test1/screens/home_screen.dart';
import 'user_list/bloc/user_list_bloc.dart';
import 'user_list/bloc/user_list_event.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => UserListBloc()..add(FetchUsers())),
      ],
      child: MaterialApp(
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
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
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
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      
        //check what theme system uses
        themeMode: ThemeMode.system,
      
        //Application
        home: const HomeScreen()
      ),
    ),
  );
}
