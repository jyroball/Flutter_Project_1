import 'package:flutter/material.dart';

class Step1Form extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;
  final DateTime? newBirthdate;
  final Function(DateTime) newBirthDate;
  final Function(String) newFirstName;
  final Function(String) newLastName;
  final Function(String) newOccuputaion;
  final Function(String) newBio;
  final VoidCallback next;
  final int newAge;

  //
  const Step1Form({
    super.key,
    required this.formKey,
    required this.newBirthdate,
    required this.newBirthDate,
    required this.newFirstName,
    required this.newLastName,
    required this.newOccuputaion,
    required this.newBio,
    required this.next,
    required this.newAge,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      );
  }
}
