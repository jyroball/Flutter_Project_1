// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      age: (json['age'] as num).toInt(),
      bio: json['bio'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthdate': instance.birthdate.toIso8601String(),
      'age': instance.age,
      'bio': instance.bio,
      'email': instance.email,
      'password': instance.password,
    };
