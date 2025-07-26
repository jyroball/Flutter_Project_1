import 'package:equatable/equatable.dart';
import 'package:test1/models/user_entity.dart';

class UserState extends Equatable {
  //variables for bloc state
  final UserEntity user;
  final int currentStep;
  final bool isSubmitting;
  final bool isSubmissionSuccess;
  final bool showRetryDialog;
  final bool chooseBday;          //for outputing birthdate
  final String? errorMessage;
  final String? serverMessage;

  const UserState({
    required this.user,
    this.currentStep = 0,
    this.isSubmitting = false,
    this.isSubmissionSuccess = false,
    this.showRetryDialog = false,
    this.chooseBday = false,
    this.errorMessage,
    this.serverMessage,
  });

  //initial state of bloc data
  factory UserState.initial() {
    return UserState(
      user: UserEntity(
        firstName: '',
        lastName: '',
        birthdate: DateTime.now(),
        age: 0,
        bio: '',
        email: '',
        password: '',
      ),
      currentStep: 0,
      isSubmitting: false,
      isSubmissionSuccess: false,
      chooseBday: false,
      errorMessage: null,
      serverMessage: '',
    );
  }

  UserState copyWith({
    UserEntity? user,
    int? currentStep,
    bool? isSubmitting,
    bool? isSubmissionSuccess,
    bool? showRetryDialog,
    bool? chooseBday,
    String? errorMessage,
    String? serverMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      currentStep: currentStep ?? this.currentStep,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmissionSuccess: isSubmissionSuccess ?? this.isSubmissionSuccess,
      showRetryDialog: showRetryDialog ?? this.showRetryDialog,
      chooseBday: chooseBday ?? this.chooseBday,
      errorMessage: errorMessage,
      serverMessage: serverMessage ?? this.serverMessage,
    );
  }

  @override
  List<Object?> get props => [user, currentStep, isSubmitting, isSubmissionSuccess, showRetryDialog, chooseBday, errorMessage];
}
