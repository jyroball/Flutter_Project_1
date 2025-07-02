import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BioScreen extends StatelessWidget {
  const BioScreen(this.startQuiz, {super.key}); //pass a void function from quiz.dart

  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',  //Change to Picture
            width: 300,
            color: const Color.fromARGB(175, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          //Add mopre tyext in here
          Text(
            'More Information: ',
            style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ), 
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            label: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}