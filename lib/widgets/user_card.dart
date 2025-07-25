import 'package:test1/models/user_entity.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.goBio, required this.user});

  final UserEntity user;
  final VoidCallback goBio;

  @override
  Widget build(BuildContext context) {
    //Card() : styling purpose that looks like a card, looks nice
    //have card with profile pic on side then name and occupation
    //have a floating button on right of card to view full profile
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        //circular avatar
        leading: Container(
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
        //name
        title: Text('${user.firstName} ${user.lastName}'),
        //occupation
        //subtitle: Text(user.occupation),
        subtitle: Text(user.email),
        //button to view bio
        trailing: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: goBio,
        ),
      ),
    );
  }
}