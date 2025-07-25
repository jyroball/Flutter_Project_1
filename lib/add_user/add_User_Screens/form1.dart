import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc imports
import '../bloc/add_user_bloc.dart';
import '../bloc/add_user_event.dart';
import '../bloc/add_user_state.dart';

class FormOne extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;

  const FormOne({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;
        final chooseBday = state.chooseBday;

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
                          initialValue: user.firstName,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            hintText: 'John',
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'First Name is required' : null,
                          onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(firstName: val)),
                        ),
                  
                        //Output Last name input box
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user.lastName,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Doe',
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Last Name is required' : null,
                          onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(lastName: val)),
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
                                  text: chooseBday == true
                                      ? '${user.birthdate.month.toString().padLeft(2, '0')}/${user.birthdate.day.toString().padLeft(2, '0')}/${user.birthdate.year}'
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
                                    context.read<UserBloc>().add(UpdateUserField(birthDate: picked));
                                  }
                                },
                                validator: (_) => chooseBday == false ? 'Birthdate is required' : null,
                              ),
                            ),
        
                            const SizedBox(width: 12),
        
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                readOnly: true,
                                decoration: const InputDecoration(labelText: 'Age'),
                                controller: TextEditingController(text: chooseBday == true ? user.age.toString() : ''),
                              ),
                            ),
                          ],
                        ),
        
                        // //Output Occupation Input
                        // const SizedBox(height: 12),
                        // TextFormField(
                        //   initialValue: user.occupation,
                        //   decoration: const InputDecoration(
                        //     labelText: 'Occupation',
                        //     hintText: 'Job Title',
                        //   ),
                        //   validator: (val) => val == null || val.isEmpty ? 'Occupation is required' : null,
                        //   onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(occupation: val)),
                        // ),
        
                        //Output Bio Input
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: user.bio,
                          decoration: const InputDecoration(
                            labelText: 'Biography',
                            hintText: 'Describe yourself, what do you do, who are you?',
                          ),
                          maxLines: 5,
                          validator: (val) => val == null || val.isEmpty ? 'Biography is required' : null,
                          onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(bio: val)),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
