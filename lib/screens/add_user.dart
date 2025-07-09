import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime? birthDate;
  int age = 0;
  String occupation = '';
  String bio = '';
  String email = '';
  String password = '';     //since they need a password too
  //final String imagePath;     IDK how to implement this for now
  
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

  

  //build forms
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

}