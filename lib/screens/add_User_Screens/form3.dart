import 'package:flutter/material.dart';

class Step3Review extends StatelessWidget {
  final String firstName;
  final String lastName;
  final DateTime? birthdate;
  final int age;
  final String occupation;
  final String bio;
  final String email;
  final VoidCallback back;
  final VoidCallback submit;

  const Step3Review({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.occupation,
    required this.bio,
    required this.email,
    required this.back,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    
  }
}
