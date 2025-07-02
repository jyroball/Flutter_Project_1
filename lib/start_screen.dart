import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startScreen, {super.key}); //pass a void function from quiz.dart

  final void Function() startScreen;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',  //Change to photo of myself Later
            width: 300,
            color: const Color.fromARGB(175, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          Text(
            'Jyro Jimenez',
            style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ), 
          ),
          const SizedBox(
            height: 30,
          ),
          //Use this button to change screen to bio
          OutlinedButton.icon(
            onPressed: startScreen,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            label: const Text('More Info...'),
          ),
        ],
      ),
    );
  }
}