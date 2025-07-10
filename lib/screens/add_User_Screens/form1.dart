import 'package:flutter/material.dart';

class FormOne extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;
  final Function(String) newFirstName;
  final Function(String) newLastName;
  final DateTime? newBirthdate;
  final int newAge;
  final Function(DateTime) newBirthDateCall;
  final Function(String) newOccuputaion;
  final Function(String) newBio;

  //naviagtion variables
  final VoidCallback next;

  //passed vars
  const FormOne({
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
                    const Text("1 out of 3", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    const Text("Personal Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Input your personal information. All fields are required.",
                        style: TextStyle(color: Colors.grey)),
              
                    //Output First name Input box
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        hintText: 'John',
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'First Name is required' : null,
                      onSaved: (val) => newFirstName(val!),
                    ),
              
                    //Output Last name input box
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Doe',
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Last Name is required' : null,
                      onSaved: (val) => newLastName(val!),
                    ),
                    
                    //Output Birthdate picker and Get Age
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'Birthdate'),
                            controller: TextEditingController(
                              text: newBirthdate != null
                                  ? '${newBirthdate!.month.toString().padLeft(2, '0')}/${newBirthdate!.day.toString().padLeft(2, '0')}/${newBirthdate!.year}'
                                  : '',
                            ),
                            //show calendar to pick date
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1925),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                newBirthDateCall(picked);
                              }
                            },
                            validator: (_) => newBirthdate == null ? 'Birthdate is required' : null,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(labelText: 'Age'),
                            controller: TextEditingController(text: newAge.toString()),
                          ),
                        ),
                      ],
                    ),

                    //Output Occupation Input
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Occupation',
                        hintText: 'Job Title',
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Occupation is required' : null,
                      onSaved: (val) => newOccuputaion(val!),
                    ),

                    //Output Bio Input
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Biography',
                        hintText: 'Describe yourself, what do you do, who are you?',
                      ),
                      maxLines: 5,
                      validator: (val) => val == null || val.isEmpty ? 'Biography is required' : null,
                      onSaved: (val) => newBio(val!),
                    ),
                    
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
