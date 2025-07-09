import 'package:test1/models/user.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    //Card() : styling purpose that looks like a card, looks nice
    //have card with profile pic on side then name and occupation
    //have a floating button on right of card to view full profile
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Profile picture
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 4,
                ),
              ),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/blank.png'),
              ),
            ),
            
            //Name and Occupation
            Column(
              children: [
                //first then last name
                Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                //occupation below name
                Text(user.occupation, style: const TextStyle(fontSize: 16)),
              ],
            ),

            //Floating button for viewing user aligned at the end


            
          ],
        ),
      ),
    );
  }
}