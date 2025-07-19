import 'package:equatable/equatable.dart';
import 'package:test1/models/user.dart';

class UserState extends Equatable {
  //variables for bloc state
  final User user;
  final int currentStep;
  final bool isSubmitting;
  final bool isSubmissionSuccess;
  final String? error;

  const UserState({
    required this.user,
    this.currentStep = 0,
    this.isSubmitting = false,
    this.isSubmissionSuccess = false,
    this.error,
  });

  //initial state of bloc data
  factory UserState.initial() {
    return UserState(
      user: User(
        firstName: '',
        lastName: '',
        birthDate: DateTime.now(),
        age: 0,
        occupation: '',
        bio: '',
        email: '',
        password: '',
        imagePath: 'assets/images/blank.png',
      ),
      currentStep: 0,
      isSubmitting: false,
      isSubmissionSuccess: false,
      error: null,
    );
  }

  UserState copyWith({
    User? user,
    int? currentStep,
    bool? isSubmitting,
    bool? isSubmissionSuccess,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmissionSuccess: isSubmissionSuccess ?? this.isSubmissionSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, currentStep, isSubmitting, isSubmissionSuccess, error];
}
