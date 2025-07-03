import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.next, {super.key}); //pass a void function from quiz.dart

  final void Function() next;

  @override 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            //profile pic with border
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),

            //name and posiution
            const Column(
              children: [
                Text(
                  'Jyro Jimenez',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Software Engineer',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ],
            ),

            const Spacer(),

            //button for details page
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: next,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}