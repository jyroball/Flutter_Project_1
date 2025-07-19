import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_user_event.dart';
import 'add_user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    on<UpdateUserField>(_onUpdateUserField);
    on<SubmitUser>(_onSubmitUser);
    on<NextStep>(_onNextStep);
    on<PreviousStep>(_onPreviousStep);
    on<ResetForm>((event, emit) {
      emit(UserState.initial());
    });
  }

  void _onUpdateUserField(UpdateUserField event, Emitter<UserState> emit) {
    final updatedUser = state.user.copyWith(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      birthDate: event.birthDate,
      occupation: event.occupation,
      bio: event.bio,
      age: event.birthDate != null ? _calculateAge(event.birthDate!) : state.user.age,
    );

    emit(state.copyWith(user: updatedUser));
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
    emit(state.copyWith(isSubmitting: true));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(isSubmitting: false, isSubmissionSuccess: true));

    on<ResetForm>((event, emit) {
      emit(UserState.initial());
    });
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