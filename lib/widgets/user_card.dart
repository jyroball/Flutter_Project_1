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
            Text(expense.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4,),
            Row(
              children: [
                //toStringAsFixed outputs a fixed amount of float values (2 Decimal places)
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                //adding another row into row pushes the next values to the right half
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}