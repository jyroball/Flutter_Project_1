//package to get unique id parameters like a GUID value
//import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//add equitable for later use
import 'package:equatable/equatable.dart';

final formatter = DateFormat.yMd();

//utility object to generate a unique id
//const uuid = Uuid();

class User extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final int age;
  final String occupation;
  final String bio;
  final String email;
  final String password;    //Store this here for now, definetly need another model for user authentication
  final String imagePath;

  const User({
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

  //for equitable
  @override
  List<Object?> get props => [
    firstName,
    lastName,
    birthDate,
    age,
    occupation,
    bio,
    email,
    password,
    imagePath,
  ];

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

  //copy function for bloc
  User copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    int? age,
    String? occupation,
    String? bio,
    String? email,
    String? password,
    String? imagePath,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      age: age ?? this.age,
      occupation: occupation ?? this.occupation,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      password: password ?? this.password,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}