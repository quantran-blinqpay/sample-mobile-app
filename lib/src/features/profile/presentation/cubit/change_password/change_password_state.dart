// ignore_for_file: must_be_immutable

part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordFail extends ChangePasswordState {
  ChangePasswordFail({required this.message});
  String message;
  @override
  List<Object?> get props => [message];
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordInvalid extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NewPasswordInvalid extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RepeatPasswordInvalid extends ChangePasswordState {
  @override
  List<Object?> get props => throw UnimplementedError();
}