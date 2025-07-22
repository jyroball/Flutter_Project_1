import 'package:equatable/equatable.dart';

//import model
import 'package:test1/models/user_entity.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserListEvent {}

class RefreshUsers extends UserListEvent {}

class AddUserLocally extends UserListEvent {
  final UserEntity user;

  AddUserLocally(this.user);

  @override
  List<Object?> get props => [user];
}