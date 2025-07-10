import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:test1/models/user.dart';

//import different form screens
import 'package:test1/screens/add_User_Screens/form1.dart';
import 'package:test1/screens/add_User_Screens/form2.dart';
import 'package:test1/screens/add_User_Screens/form3.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> with SingleTickerProviderStateMixin {
  //tabcontroller for forms
  late TabController _tabController;
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  //local input for user info
  String firstName = '';
  String lastName = '';
  DateTime birthDate = DateTime.now();
  int age = 0;
  String occupation = '';
  String bio = '';
  String email = '';
  String password = '';     //since they need a password too
  //final String imagePath;     IDK how to implement this for now
  String confirmPassword = '';
  bool showPassword = false;
  bool showConfirmPassword = false;
  
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
  void _nextTab() {
    final form = _formKeys[_tabController.index].currentState!;
    if (form.validate()) {
      form.save();
      if (_tabController.index < 2) {
        _tabController.animateTo(_tabController.index + 1);
      }
    }
  }

  //move to prev tab by decrementing index
  void _prevTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  //submit function
  void _submit() {
    final newUser = User(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      age: _calculateAge(birthDate),
      occupation: occupation,
      bio: bio,
      email: email,
      password: password,
      imagePath: 'assets/images/blank.png',
    );

    //pass values to profile page and add new user
    Navigator.pop(context, newUser);
  }

  //calculate age from birthdate
  int _calculateAge(DateTime? bday) {
    //no date can't happen, just incase
    if (bday == null) return 0;
    //get today's date and subtract from bday
    final today = DateTime.now();
    int age = today.year - bday.year;
    //edge case with months and day
    if (bday.month > today.month || (bday.month == today.month && bday.day > today.day)) {
      age--;
    }
    return age;
  }

  //build forms
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      //Use tab bar view to controll pages
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //First Form
          FormOne(
            formKey: _formKeys[0],
            newFirstName: (val) => firstName = val,
            newLastName: (val) => lastName = val,
            newBirthdate: birthDate,
            newAge: _calculateAge(birthDate),
            newOccuputaion: (val) => occupation = val,
            newBio: (val) => bio = val,
            newBirthDateCall: (date) => setState(() => birthDate = date),
            next: _nextTab,
          ),

          //Second form
          FormTwo(
            formKey: _formKeys[1],
            password: password,
            showPassword: showPassword,
            showConfirmPassword: showConfirmPassword,
            togglePassword: () => setState(() => showPassword = !showPassword),
            toggleConfirmPassword: () => setState(() => showConfirmPassword = !showConfirmPassword),
            newEmail: (val) => email = val,
            newPassword: (val) => setState(() => password = val),
            newPasswordConfirm: (val) => confirmPassword = val,
            next: _nextTab,
            back: _prevTab,
          ),

          //third form
          FormThree(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            age: _calculateAge(birthDate),
            occupation: occupation,
            bio: bio,
            email: email,
            back: _prevTab,
            submit: _submit,
          ),
        ],
      ),
    );
  }
}