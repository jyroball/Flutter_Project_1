import 'package:flutter/material.dart';

class Step2Form  extends StatelessWidget {
  //variables to send back to add_user page
  final GlobalKey<FormState> formKey;
  final Function(String) newEmail;
  final Function(String) newPassword;
  final Function(String) newPasswordConfirm;

  //local variabel
  final bool showPassword;
  final bool showConfirmPassword;
  final VoidCallback togglePassword;
  final VoidCallback toggleConfirmPassword;
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
    required this.showConfirmPassword,
    required this.togglePassword,
    required this.toggleConfirmPassword,
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
                      onSaved: (val) => newEmail(val!),
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
                          onPressed: togglePassword,
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
                      onChanged: newPassword,
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
                          onPressed: toggleConfirmPassword,
                        ),
                      ),
                      validator: (val) {
                        //make sure there's an entry
                        if (val == null || val.isEmpty) {
                          return 'Password is required';
                        }
                        //check if passwords match
                        if (val != password) {
                          return 'Passwords do not match';
                        }
                        //valid so return niull
                        return null;
                      },
                      onSaved: (val) => newPasswordConfirm(val!),
                    ),
                    
                  ],
                ),
              ),
            ),

            //Next Button
            Row(
              children: [
                //Back Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ElevatedButton(
                      onPressed: back,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 154, 147, 147),
                      ),
                      child: const Text("Back", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                //Next Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: ElevatedButton(
                        onPressed: next,
                        child: const Text("Next", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
