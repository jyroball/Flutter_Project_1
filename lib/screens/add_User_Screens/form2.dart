import 'package:flutter/material.dart';

class Step2Form  extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;
  final Function(String) newEmail;
  final Function(String) newPassword;
  final Function(String) newPasswordConfirm;

  //local variabel
  final bool showPassword;
  final VoidCallback togglePasswordVisibility;
  final String password;

  //navigation varioables
  final VoidCallback next;
  final VoidCallback back;

  //passed avrs
  const Step2Form ({
    super.key,
    required this.formKey,
    required this.newEmail,
    required this.newPassword,
    required this.newPasswordConfirm,
    required this.showPassword,
    required this.togglePasswordVisibility,
    required this.password,
    required this.next,
    required this.back,
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
                    const Text("2 out of 3", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    const Text("Email & Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Enter Login Information...",
                        style: TextStyle(color: Colors.grey)),
              
                    //Output Email address input
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email Address'),
                      //NEED TO VAIDATE FOR AN ACTUAL EMAIL
                      validator: (val) {
                        //make sure there's an entry
                        if (val == null || val.isEmpty) {
                          return 'Email Address is required';
                        }
                        //make sure entry is an actual email
                        final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!regex.hasMatch(val)) {
                          return 'Enter a valid email address';
                        }
                        //valid so return niull
                        return null;
                      },
                      //ALSO ADD EMAIL KEYBOARD TOO
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (val) => newEmail(val!),
                    ),
              
                    //Output Last name input box
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Last Name'),
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
                      decoration: const InputDecoration(labelText: 'Occupation'),
                      validator: (val) => val == null || val.isEmpty ? 'Occupation is required' : null,
                      onSaved: (val) => newOccuputaion(val!),
                    ),

                    //Output Bio Input
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Bio - Describe yourself'),
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
