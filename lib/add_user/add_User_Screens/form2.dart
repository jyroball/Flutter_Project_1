import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc imports
import '../bloc/add_user_bloc.dart';
import '../bloc/add_user_event.dart';
import '../bloc/add_user_state.dart';

//change to statefull widgetb for password toggle since handle it here now, to pass less vals from add user screen
class FormTwo extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const FormTwo({super.key, required this.formKey});

  @override
  State<FormTwo> createState() => _FormTwoState();
}

class _FormTwoState extends State<FormTwo> {
  //local variables to use for pass toggle
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final user = state.user;

        return Form(
          key: widget.formKey,
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
                        const Text("Email & Password", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const Text("Enter Login Information...",
                            style: TextStyle(color: Colors.grey)),
                  
                        //Output Email address input
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: user.email,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'john.doe@gmail.com',
                          ),

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
                          onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(email: val)),
                        ),
                  
                        //Output Password input biox\
                        const SizedBox(height: 16),
                        TextFormField(
                          //obscure text if show password or not
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '> 8 Characters, 1 Special, 1 Digit',
                            suffixIcon: IconButton(
                              icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                          validator: (val) {
                            //make sure there's an entry
                            if (val == null || val.isEmpty) {
                              return 'Password is required';
                            }
                            //have a regex to make sure input has at least one special character, at least one number and length is > 8
                            //(?=.*[0-9]) - at least one number
                            //(?=.*[~!@#$%&*]) - at least one spceial character
                            //[a-zA-Z0-9~!@#\$%&*] - characters allowed
                            final regex = RegExp(r'^(?=.*[0-9])(?=.*[~!@#$%&*])[a-zA-Z0-9~!@#\$%&*]{8,}$');
                            if (!regex.hasMatch(val)) {
                              return 'Enter a valid password';
                            }
                            //valid so return niull
                            return null;
                          },
                          onChanged: (val) => context.read<UserBloc>().add(UpdateUserField(password: val)),
                        ),
        
                        //
                        //  Maybe add a small text here?? since hint too long for input box????
                        //
        
                        //Output Confirm Password input biox\
                        const SizedBox(height: 16),
                        TextFormField(
                          //obscure text if show password or not
                          obscureText: !showConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Passwords must match',
                            suffixIcon: IconButton(
                              icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  showConfirmPassword = !showConfirmPassword;
                                });
                              },
                            ),
                          ),
                          validator: (val) {
                            //make sure there's an entry
                            if (val == null || val.isEmpty) {
                              return 'Password is required';
                            }
                            //check if passwords match
                            if (val != user.password) {
                              return 'Passwords do not match';
                            }
                            //valid so return niull
                            return null;
                          },
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
