import 'package:flutter/material.dart';

class BioScreen extends StatelessWidget {
  const BioScreen(this.back, {super.key}); //pass a void function from quiz.dart

  final void Function() back;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),

                const SizedBox(width: 16),

                //column for name and position
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jyro Jimenez',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Software Engineer',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            //biographtuy
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'I am a firmware developer from University of California, Riverside. I am currently studying flutter to get better at mobile development and have more experience under my tool box.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const Spacer(),

            //button to go back
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: back,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Start'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}