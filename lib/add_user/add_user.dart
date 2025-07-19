import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:test1/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import bloc files
import 'bloc/add_user_bloc.dart';
import 'bloc/add_user_event.dart';
import 'bloc/add_user_state.dart';

//import different form screens
import 'package:test1/add_user/add_User_Screens/form1.dart';
import 'package:test1/add_user/add_User_Screens/form2.dart';
import 'package:test1/add_user/add_User_Screens/form3.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> with SingleTickerProviderStateMixin {
  //tabcontroller for forms
  late TabController _tabController;
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  // //local input for user info
  // String firstName = '';
  // String lastName = '';
  // DateTime birthDate = DateTime.now();
  // int age = 0;
  // String occupation = '';
  // String bio = '';
  // String email = '';
  // String password = '';     //since they need a password too
  // //final String imagePath;     IDK how to implement this for now
  // String confirmPassword = '';
  // bool showPassword = false;
  // bool showConfirmPassword = false;
  
  //Init state then need a dispose state since using controlelr
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //
  //  Functions for submiting form data
  //

  //move to next tab by incrementing index
  void _nextStep(BuildContext context, int currentStep) {
    final form = _formKeys[currentStep].currentState;
    if (form != null && form.validate()) {
      form.save();
      context.read<UserBloc>().add(NextStep());
    }
  }

  //move to prev tab by decrementing index
  void _prevStep(BuildContext context) {
    context.read<UserBloc>().add(PreviousStep());
  }

  // //submit function
  // void _submit() {
  //   final newUser = User(
  //     firstName: firstName,
  //     lastName: lastName,
  //     birthDate: birthDate,
  //     age: _calculateAge(birthDate),
  //     occupation: occupation,
  //     bio: bio,
  //     email: email,
  //     password: password,
  //     imagePath: 'assets/images/blank.png',
  //   );

  //   //pass values to profile page and add new user
  //   Navigator.pop(context, newUser);
  // }

  //
  //  NEW SUBMIT FUNCTION USING BLOC
  //
  void _submit(BuildContext context) {
    context.read<UserBloc>().add(const SubmitUser());
  }

  // //calculate age from birthdate
  // int _calculateAge(DateTime? bday) {
  //   //no date can't happen, just incase
  //   if (bday == null) return 0;
  //   //get today's date and subtract from bday
  //   final today = DateTime.now();
  //   int age = today.year - bday.year;
  //   //edge case with months and day
  //   if (bday.month > today.month || (bday.month == today.month && bday.day > today.day)) {
  //     age--;
  //   }
  //   return age;
  // }

  //build forms
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          //make sure tabbarview is on the same page as bloc state
          if (_tabController.index != state.currentStep) {
            _tabController.animateTo(state.currentStep);
          }

          //go through this once submission done properly
          if (state.isSubmissionSuccess) {
            //send message user added
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User successfully added!')),
            );

            //send data
            Navigator.pop(context, state.user);

            //reset bloc data so data doesn't show up again if we add a new user
            context.read<UserBloc>().add(const ResetForm());
          }
        },

        //build all three form screens
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FormOne(formKey: _formKeys[0]),
              FormTwo(formKey: _formKeys[1]),
              const FormThree(),
            ],
          );
        },
      ),

      //Persistent Bottom Button
      bottomNavigationBar: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [

                  //Output back button if not at page 1
                  if (state.currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _prevStep(context),
                        child: const Text('Back'),
                      ),
                    ),

                  //Space box
                  if (state.currentStep > 0) const SizedBox(width: 12),

                  //Output Next button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.currentStep < 2) {
                          _nextStep(context, state.currentStep);
                        } else {
                          _submit(context);
                        }
                      },
                      child: Text(state.currentStep < 2 ? 'Next' : 'Submit'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}