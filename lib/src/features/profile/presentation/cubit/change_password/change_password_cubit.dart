import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/features/profile/domain/repositories/profile_repository.dart';

import '../../../domain/model/user_data.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.repository) : super(ChangePasswordInitial());

  final ProfileRepository repository;

  Future<void> changePassword({
    required String password,
    required String newPassword
  }) async {
    emit(ChangePasswordLoading());
    final response = await repository.changePassword(password: password, newPassword: newPassword);
    response.fold((error) {
      emit(ChangePasswordFail(message: (error as DetailFailure).message ?? ''));
    }, (data) {
      emit(ChangePasswordSuccess());
    });
  }

  bool checkPassword(String password){
    bool valid = password.isNotEmpty;
    if (!valid) {
      emit(PasswordInvalid());
    }
    return valid;
  }

  bool checkNewPassword({required String password, required String newPassword}){
    bool valid = password.isNotEmpty && newPassword.isNotEmpty && password != newPassword;
    if (!valid) {
      emit(NewPasswordInvalid());
    }
    return valid;
  }

  bool checkRepeatPassword({required String newPassword, required String repeatPassword}){
    bool valid = newPassword.isNotEmpty && repeatPassword.isNotEmpty && newPassword == repeatPassword;
    if (!valid) {
      emit(RepeatPasswordInvalid());
    }
    return valid;
  }

  @override
  Future<void> close() {
    repository.cancelRequest();
    return super.close();
  }
}
