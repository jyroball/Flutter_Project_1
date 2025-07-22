import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/api_services/api_client.dart';
import 'add_user_event.dart';
import 'add_user_state.dart';

import 'package:dio/dio.dart';
import 'package:test1/api_services/api_retrofit.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  //api
  final UserApiService api = UserApiService(ApiClient.dio);

  UserBloc() : super(UserState.initial()) {
    on<UpdateUserField>(_onUpdateUserField);
    on<SubmitUser>(_onSubmitUser);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<ResetForm>((event, emit) {
      emit(UserState.initial());
    });
    on<SubmitUserRequested>(_onSubmitUserRequested);
  }

  void _onUpdateUserField(UpdateUserField event, Emitter<UserState> emit) {
    final updatedUser = state.user.copyWith(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      birthDate: event.birthDate,
      bio: event.bio,
      age: event.birthDate != null ? _calculateAge(event.birthDate!) : state.user.age,
    );

    emit(state.copyWith(user: updatedUser, chooseBday: event.birthDate != null ? true : state.chooseBday,));
  }

  void _onNextStep(NextStep event, Emitter<UserState> emit) {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPreviousStep(PreviousStep event, Emitter<UserState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> _onSubmitUser(SubmitUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(isSubmitting: true, showRetryDialog: false, errorMessage: null));

    try {
      final res = await api.registerUser(state.user);
      String msg = 'User registered successfully!';
      if (res is Map && res['message'] is String) {
        msg = res['message'] as String;
      }

      emit(state.copyWith(
        isSubmitting: false,
        isSubmissionSuccess: true,
        serverMessage: msg,
      ));
    } 
    on DioException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        showRetryDialog: true,
        errorMessage: _dioToMessage(e),
      ));
    } 
    catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        showRetryDialog: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitUserRequested(SubmitUserRequested event, Emitter<UserState> emit) async {
    emit(state.copyWith(isSubmitting: true, showRetryDialog: false, errorMessage: null));

    try {
      await api.triggerError();
      emit(state.copyWith(
        isSubmitting: false,
        showRetryDialog: true,
        errorMessage: 'Unexpected: error endpoint did not fail.',
      ));
    } 
    on DioException catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        showRetryDialog: true,
        errorMessage: e.response?.data?.toString() ?? e.message ?? 'Unknown error',
      ));
    } 
    catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        showRetryDialog: true,
        errorMessage: e.toString(),
      ));
    }
  }

  String _dioToMessage(DioException e) {
    final data = e.response?.data;
    if (data is String) return data;
    if (data is Map && data['message'] is String) return data['message'] as String;
    return e.message ?? 'Unknown network error';
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (birthDate.month > today.month ||
        (birthDate.month == today.month && birthDate.day > today.day)) {
      age--;
    }
    return age;
  }
}