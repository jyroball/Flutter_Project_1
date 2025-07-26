import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//bloc imports
import '../bloc/add_user_bloc.dart';
import '../bloc/add_user_state.dart';

final formatter = DateFormat.yMd();

class FormThree extends StatelessWidget {
  const FormThree({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;

        //use this instead since user can't be accessed by helper function
        String formattedDate = formatter.format(user.birthdate);

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
            ],
          ),
        );
      }
    );
  }
}
