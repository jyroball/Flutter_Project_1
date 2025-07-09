import 'package:flutter/material.dart';
//Different screens for bio
//import 'package:test1/screens/start_screen.dart';
import 'package:test1/screens/bio_screen.dart';
//import model
import 'package:test1/models/user.dart';
//import reusable widghets
import 'package:test1/widgets/user_card.dart';
//date time
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  //no build method if stateful widget
  @override
  State<Profile> createState() => _ProfileState();
}

// "_" means that class is a private class for the file
class _ProfileState extends State<Profile> {
  //have an array for the list of users (for now add an initial user as me and random so we can see output)
  final List<User> users = [
    User(
      firstName: 'Jyro', 
      lastName: 'Jimenez', 
      birthDate: DateFormat('MM/dd/yyyy').parse('11/24/2001'),
      age: 23,
      occupation: 'Software Developer', 
      bio: 'I am a firmware developer from University of California, Riverside. I am currently studying flutter to get better at mobile development and have more experience under my tool box.', 
      email: 'jyrojimenez@gmail.com',
      password: 'test12345!',
      imagePath: 'assets/images/profile.jpg'
    ),
    User(
      firstName: 'John', 
      lastName: 'Jones', 
      birthDate: DateFormat('MM/dd/yyyy').parse('1/1/2000'),
      age: 24,
      occupation: 'Software Developer', 
      bio: 'I am a Software Developer created to be a random person for a flutter project.', 
      email: 'johndoe@gmail.com',
      password: 'test12345!',
      imagePath: 'assets/images/blank.png'
    ),
  ];

  //
  //  NEED TO MAKE A ADD USER FORM LATER
  //

  //I need an init state later when I connect to a DB to read from it, since data is hard coded rn should be fine

  //Using user card button view profile
  void _viewBio(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BioScreen(user: user)),
    );
  }

  //just output cards of users
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: ListView.builder(
        itemCount: users.length,
        //similar top old project, can prob add id to user card and make cards dismissable
        itemBuilder: (ctx, i) => UserCard(user: users[i], goBio: () => _viewBio(users[i])),
      ),
    );
  }
}