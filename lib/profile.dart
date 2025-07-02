import 'package:flutter/material.dart';
//Different screens for bio
import 'package:test1/start_screen.dart';
import 'package:test1/bio_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  //no build method if stateful widget
  @override
  State<Profile> createState() {
    return _ProfileState();
  }

}

// "_" means that class is a private class for the file
class _ProfileState extends State<Profile> {
  //nullable widget for now when intializing
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  //Starts an initialization logic when objects are created
  @override
  void initState() {
    //change widets, make sure variable is a widget since var sets it as a StartScreen object
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  //Switch between bio nad more information
  void switchScreen() {
    setState(() {
      activeScreen = BioScreen(switchScreen);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                 Color.fromARGB(255, 76, 8, 159),
                 Color.fromARGB(255, 111, 18, 252)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
              ),
            ),
          child: activeScreen,
        ),
      ),
    );
  }
}