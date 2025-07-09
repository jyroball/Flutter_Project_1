import 'package:flutter/material.dart';
//import model
import 'package:test1/models/user.dart';

class BioScreen extends StatelessWidget {
  //we start using navigator to change screens instead of just changing screens
  const BioScreen({required this.user, super.key}); //pass a void function from quiz.dart
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top row with icon and text
              Row(
                children: [
                  //containter for profile picture with border
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(user.imagePath),
                    ),
                  ),

                  const SizedBox(width: 16),

                  //column for name and position
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //first then last name
                      Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      //occupation below name
                      Text(user.occupation, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //General Information
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Birth Date: ${user.formattedDate}\n'
                      'Age: ${user.age}\n'
                      'Email: ${user.email}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //biographtuy
              SizedBox(
                width: double.infinity,
                child:Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      user.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}