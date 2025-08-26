// ignore_for_file: must_be_immutable

part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.token,
    this.username,
    this.isFromAud,
    this.user,
    this.errorMessage,
    this.rememberMe,
    this.signInStatus = ProgressStatus.initial,
    this.signOutStatus = ProgressStatus.initial,
    this.getTokenStatus = ProgressStatus.initial,
    this.registerStatus = ProgressStatus.initial,
    this.forgotPasswordStatus = ProgressStatus.initial,
    this.checkAccessTokenStatus = ProgressStatus.initial,
  });

  final String? token;
  final String? username;
  final bool? isFromAud;
  final UserData? user;
  final String? errorMessage;
  final bool? rememberMe;

  final ProgressStatus signInStatus;
  final ProgressStatus signOutStatus;
  final ProgressStatus getTokenStatus;
  final ProgressStatus registerStatus;
  final ProgressStatus forgotPasswordStatus;
  final ProgressStatus checkAccessTokenStatus;

  bool get isSignedIn => token?.isNotEmpty == true;

  AuthState copyWith({
    String? token,
    String? username,
    bool? isFromAud,
    UserData? user,
    String? email,
    String? password,
    String? errorMessage,
    bool? rememberMe,
    ProgressStatus? signInStatus,
    ProgressStatus? signOutStatus,
    ProgressStatus? getTokenStatus,
    ProgressStatus? registerStatus,
    ProgressStatus? forgotPasswordStatus,
  }) {
    return AuthState(
      token: token ?? this.token,
      username: username ?? this.username,
      isFromAud: isFromAud ?? this.isFromAud,
      user: user ?? this.user,
      rememberMe: rememberMe ?? this.rememberMe,
      errorMessage: errorMessage ?? this.errorMessage,
      signInStatus: signInStatus ?? this.signInStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      getTokenStatus: getTokenStatus ?? this.getTokenStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
    );
  }

  @override
  List<Object?> get props => [
        token,
        username,
        isFromAud,
        user,
        rememberMe,
        errorMessage,
        rememberMe,
        signInStatus,
        signOutStatus,
        getTokenStatus,
        registerStatus,
        forgotPasswordStatus,
        isSignedIn,
        checkAccessTokenStatus,
      ];
}
