import 'package:flutter/material.dart';
//Different screens for bio
//import 'package:test1/screens/start_screen.dart';
import 'package:test1/screens/bio_screen.dart';
//import model
import 'package:test1/models/user.dart';
//import reusable widghets
import 'package:test1/widgets/user_card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  //no build method if stateful widget
  @override
  State<Profile> createState() => _ProfileState();
}

// "_" means that class is a private class for the file
class _ProfileState extends State<Profile> {
  //have an array for the list of users
  final List<User> users = [];

  //
  //  NEED TO MAKE A ADD USER FORM LATER
  //

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