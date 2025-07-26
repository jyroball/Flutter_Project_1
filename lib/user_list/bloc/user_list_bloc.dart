import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/api_services/api_retrofit.dart';
import 'package:test1/api_services/api_client.dart';
import 'package:test1/models/user_entity.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserApiService apiService = UserApiService(ApiClient.dio);

  UserListBloc() : super(UserListLoading()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<AddUserLocally>(_onAddUserLocally);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserListState> emit) async {
    emit(UserListLoading());
    try {
      final response = await apiService.getUsers();
      final usersJson = response['users'] as List<dynamic>;
      final users = usersJson.map((e) => UserEntity.fromJson(e)).toList();

      emit(UserListLoaded(users));
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }

  Future<void> _onRefreshUsers(RefreshUsers event, Emitter<UserListState> emit) async {
    try {
      final response = await apiService.getUsers();
      final usersJson = response['users'] as List<dynamic>;
      final users = usersJson.map((e) => UserEntity.fromJson(e)).toList();

      emit(UserListLoaded(users));
    } catch (e) {
      emit(UserListError(e.toString()));
    }
  }

  void _onAddUserLocally(AddUserLocally event, Emitter<UserListState> emit) {
    if (state is UserListLoaded) {
      final currentUsers = List<UserEntity>.from((state as UserListLoaded).users);
      currentUsers.add(event.user);
      emit(UserListLoaded(currentUsers));
    } else {
      emit(UserListLoaded([event.user]));
    }
  }
}
