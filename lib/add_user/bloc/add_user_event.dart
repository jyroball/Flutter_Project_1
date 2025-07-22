import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

//update values depending on changed values in form
class UpdateUserField extends UserEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final DateTime? birthDate;
  final String? bio;
  final String? errorMessage;

  const UpdateUserField({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.birthDate,
    this.bio,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        birthDate,
        bio,
      ];
}

//next page
class NextStep extends UserEvent {}

//back page
class PreviousStep extends UserEvent {}

//submit form and pass to json
class SubmitUser extends UserEvent {
  const SubmitUser();
}

//reset form after submitting so bloc state resets for new add user.
class ResetForm extends UserEvent {
  const ResetForm();
}

class SubmitUserRequested extends UserEvent {
  const SubmitUserRequested();
}