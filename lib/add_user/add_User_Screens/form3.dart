import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//bloc imports
import '../bloc/add_user_bloc.dart';
//import '../bloc/add_user_event.dart';
import '../bloc/add_user_state.dart';

final formatter = DateFormat.yMd();

class FormThree extends StatelessWidget {
  // final String firstName;
  // final String lastName;
  // final DateTime birthDate;
  // final int age;
  // final String occupation;
  // final String bio;
  // final String email;
  // final VoidCallback back;
  // final VoidCallback submit;

  // const FormThree({
  //   super.key,
  //   required this.firstName,
  //   required this.lastName,
  //   required this.birthDate,
  //   required this.age,
  //   required this.occupation,
  //   required this.bio,
  //   required this.email,
  //   required this.back,
  //   required this.submit,
  // });

  const FormThree({super.key});

  //Helper function to output foratted date
  // String get formattedDate {
  //   return formatter.format(user.birthDate);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;
        final currentStep = state.currentStep + 1;

        //use this instead since user can't be accessed by helper function
        String formattedDate = formatter.format(user.birthDate);

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Output instructions at the top
                      Text("${currentStep} out of 3", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      const Text("Review Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text("Please review all of your information before you continue.", style: TextStyle(color: Colors.grey)),
                      
                      //Output all information in rows
                      //Can probably make reusable widgets for these later????
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("First Name: ", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(user.firstName),
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Last Name: ", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(user.lastName),
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Birth Date: ", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(formattedDate)
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Age: ", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(user.age.toString())
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text("Email: ", style: TextStyle(fontWeight: FontWeight.bold))
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(user.email),
                          ),
                        ],
                      ),
        
                      const SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Biography - Describe yourself: ", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(user.bio),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
        
              // //Next Button
              // Row(
              //   children: [
              //     //Back Button
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              //         child: ElevatedButton(
              //           onPressed: back,
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: const Color.fromARGB(255, 154, 147, 147),
              //           ),
              //           child: const Text("Back", style: TextStyle(fontSize: 16)),
              //         ),
              //       ),
              //     ),
              //     //Next Button
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              //         child: ElevatedButton(
              //             onPressed: submit,
              //             child: const Text("Continue", style: TextStyle(fontSize: 16)),
              //         ),
              //       ),
              //     ),
              //   ]
              // ),
            ],
          ),
        );
      }
    );
  }
}
