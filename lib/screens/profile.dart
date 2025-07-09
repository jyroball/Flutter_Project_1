import 'package:flutter/material.dart';
//Different screens for bio
import 'package:test1/screens/start_screen.dart';
import 'package:test1/screens/bio_screen.dart';

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

  //boolean to know what screen we should be in
  bool isStart = true;

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
      //toggle boolean when button poreesesd
      isStart = !isStart;
    });
  }

  @override
  Widget build(context) {
    //change screeen when re rendered
    activeScreen = isStart ? StartScreen(switchScreen) : BioScreen(switchScreen);

    //change to just returning screen since we have theme to control design now
    return Scaffold(
      body: activeScreen,
    );
  }
}