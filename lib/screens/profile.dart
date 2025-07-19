import 'package:flutter/material.dart';

//Different screens for bio
//import 'package:test1/screens/start_screen.dart'
//;
import 'package:test1/screens/bio_screen.dart';
//import model
import 'package:test1/models/user.dart';

//import reusable widghets
import 'package:test1/widgets/user_card.dart';

//date time
//import 'package:intl/intl.dart';

//Import Form pages
import 'package:test1/add_user/add_user.dart';

//Import for File I/O
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  //no build method if stateful widget
  @override
  State<Profile> createState() => _ProfileState();
}

// "_" means that class is a private class for the file
class _ProfileState extends State<Profile> {
  //have an array for the list of users (for now add an initial user as me and random so we can see output)
  // final List<User> users = [
  //   User(
  //     firstName: 'Jyro', 
  //     lastName: 'Jimenez', 
  //     birthDate: DateFormat('MM/dd/yyyy').parse('11/24/2001'),
  //     age: 23,
  //     occupation: 'Software Developer', 
  //     bio: 'I am a firmware developer from University of California, Riverside. I am currently studying flutter to get better at mobile development and have more experience under my tool box.', 
  //     email: 'jyrojimenez@gmail.com',
  //     password: 'test12345!',
  //     imagePath: 'assets/images/profile.jpg'
  //   ),
  //   User(
  //     firstName: 'John', 
  //     lastName: 'Jones', 
  //     birthDate: DateFormat('MM/dd/yyyy').parse('1/1/2000'),
  //     age: 24,
  //     occupation: 'Software Developer', 
  //     bio: 'I am a Software Developer created to be a random person for a flutter project.', 
  //     email: 'johndoe@gmail.com',
  //     password: 'test12345!',
  //     imagePath: 'assets/images/blank.png'
  //   ),
  // ];

  List<User> users = [];

  //I need an init state later when I connect to a DB to read from it, since data is hard coded rn should be fine
  //Can be changed to read off a DB later like Firebase or AZuare
  @override
  void initState() {
    //REST NEED TO REMOVE LATER ONLY FOR DEBUGGING PURPOSES
    _resetUserJSONToAssetDefault();

    //Read Users here from JSON File
    _loadItems();
    super.initState();
  }

  //Load Items to call in INit
  //Load items using path, but seems extra, just place holder for now till implement DB
  Future<void> _loadItems() async {
    //get path file for json
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/user.json');

    //Use basic user.json if file does not exist yet
    if (!await file.exists()) {
      final assetData = await rootBundle.loadString('assets/data/user.json');
      await file.writeAsString(assetData);
    }

    //Deocde JSON file
    final contents = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(contents);

    //Set local user variable to JSON contents to use in application
    setState(() {
      users = jsonList.map((e) => User.fromJson(e)).toList();
    });
  }

  //Save user to JSON File
  //Can probbaly make it better with deletes and insertions, but works for now
  void _saveUsersJSON() async {
    //Get file path
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/user.json');

    //Convert users data into json
    final List<Map<String, dynamic>> userList = users.map((u) => u.toJson()).toList();

    //Upload data into json
    await file.writeAsString(jsonEncode(userList));
  }

  //
  //  FUNCTION TO RESET JSON FILE FOR DEBUGGING (List was filling up as I debug)
  //
  void _resetUserJSONToAssetDefault() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/user.json');

    final assetData = await rootBundle.loadString('assets/data/user.json');
    await file.writeAsString(assetData);

    final List<dynamic> jsonList = jsonDecode(assetData);
    setState(() {
      users = jsonList.map((e) => User.fromJson(e)).toList();
    });
  }

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
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add User',
            onPressed: () async {
              final newUser = await Navigator.push<User>(
                context,
                MaterialPageRoute(builder: (_) => const AddUserScreen()),
              );

              if (newUser != null) {
                setState(() {
                  users.add(newUser);
                });
                //Can add New User To JSON File Here too
                _saveUsersJSON();
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        //similar top old project, can prob add id to user card and make cards dismissable
        itemBuilder: (ctx, i) => UserCard(user: users[i], goBio: () => _viewBio(users[i])),
      ),
    );
  }
}