//package to get unique id parameters like a GUID value
//import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

//utility object to generate a unique id
//const uuid = Uuid();

class User {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int age;
  final String occupation;
  final String bio;
  final String email;
  final String password;    //Store this here for now, definetly need another model for user authentication
  final String imagePath;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.age,
    required this.occupation,
    required this.bio,
    required this.email,
    required this.password,
    required this.imagePath,    //Might hardcode path for now
  });

  String get formattedDate {
    return formatter.format(birthDate);
  }

  //Convert Data into JSON
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': birthDate.toIso8601String(),
    'age': age,
    'occupation': occupation,
    'bio': bio,
    'email': email,
    'password': password,
    'imagePath': imagePath,
  };

  //Read User From JSON File
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: DateTime.parse(json['birthDate']),
      age: json['age'],
      occupation: json['occupation'],
      bio: json['bio'],
      email: json['email'],
      password: json['password'],
      imagePath: json['imagePath'],
    );
  }
}