import 'package:flutter/material.dart';

class Step1Form extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;
  final Function(String) newFirstName;
  final Function(String) newLastName;
  final DateTime? newBirthdate;
  final int newAge;
  final Function(DateTime) newBirthDateCall;
  final Function(String) newOccuputaion;
  final Function(String) newBio;
  final VoidCallback next;

  //
  const Step1Form({
    super.key,
    required this.formKey,
    required this.newFirstName,
    required this.newLastName,
    required this.newBirthdate,
    required this.newAge,
    required this.newBirthDateCall,
    required this.newOccuputaion,
    required this.newBio,
    required this.next,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: Column(
          children: [

            //Text Form Inputs
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Output instructions at the top
                    const SizedBox(height: 8),
                    const Text("Personal Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Input your personal information. All fields are required.",
                        style: TextStyle(color: Colors.grey)),
              
                    //Output First name Input box
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'First Name'),
                      validator: (val) => val == null || val.isEmpty ? 'First Name is required' : null,
                      onSaved: (val) => newFirstName(val!),
                    ),
              
                    //Output Last name input box
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (val) => val == null || val.isEmpty ? 'Last Name is required' : null,
                      onSaved: (val) => newLastName(val!),
                    ),
                    
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            //Next Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: next,
                  child: const Text("Next", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
