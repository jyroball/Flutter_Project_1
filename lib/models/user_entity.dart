//Imports
import 'package:intl/intl.dart';

//add equitable for later use
import 'package:equatable/equatable.dart';

//JSON serializable import
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

final formatter = DateFormat.yMd();

@JsonSerializable()
class UserEntity extends Equatable{
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final int age;
  final String bio;
  final String email;
  final String password;    //Store this here for now, definetly need another model for user authentication

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.bio,
    required this.email,
    required this.password,
  });

  //for equitable
  @override
  List<Object?> get props => [
    firstName,
    lastName,
    birthdate,
    age,
    bio,
    email,
    password,
  ];

  String get formattedDate {
    return formatter.format(birthdate);
  }

  //
  //  JSON serializable to generate JSON instead
  //
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);


  //copy function for bloc
  UserEntity copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    int? age,
    String? bio,
    String? email,
    String? password,
  }) {
    return UserEntity(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthdate: birthDate ?? this.birthdate,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}