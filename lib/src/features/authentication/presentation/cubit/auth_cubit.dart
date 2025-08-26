import 'package:designerwardrobe/src/core/constants/app_constants.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/core/shared_prefs/country_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/profile_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/username_storage.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/code_verification_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/user_creation_parameter.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_hits_response.dart';
import 'package:designerwardrobe/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/shared_prefs/access_token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.repository, this.userRepository) : super(AuthState());

  final AuthRepository repository;

  final ProfileRepository userRepository;

  Future<void> signIn(String username, String password) async {
    emit(state.copyWith(signInStatus: ProgressStatus.inProgress));
    final response =
        await repository.signIn(userName: username, password: password);
    response.fold((error) {
      emit(state.copyWith(signInStatus: ProgressStatus.failure));
    }, (data) async {
      await di<AccessTokenStorage>().write(data);
      final userResponse = await userRepository.getBasicProfile();
      userResponse.fold((error) {
        emit(state.copyWith(signInStatus: ProgressStatus.failure));
      }, (user) async {
        await di<UsernameStorage>().write(user.username ?? '');
        await di<CountryStorage>().write(user.country ?? '');
        emit(state.copyWith(token: data, signInStatus: ProgressStatus.success));
      });
    });
  }

  void initData() async {
    emit(state.copyWith(forgotPasswordStatus: ProgressStatus.inProgress));
    var token = await di<AccessTokenStorage>().read();
    var username = await di<UsernameStorage>().read();
    var country = await di<CountryStorage>().read();
    emit(state.copyWith(
      token: token,
      username: username,
      isFromAud: country?.toLowerCase() == kAustralia,
      forgotPasswordStatus: ProgressStatus.success,
    ));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  bool checkUserName(String userName) {
    bool valid = userName.isNotEmpty;
    // if (!valid) {
    //   emit(UserNameInvalid());
    // }
    return valid;
  }

  bool checkPassword(String password) {
    bool valid = password.isNotEmpty;
    // if (!valid) {
    //   emit(PasswordInvalid());
    // }
    return valid;
  }

  bool checkFullName(String fullName) {
    bool valid = fullName.isNotEmpty;
    // if (!valid) {
    //   emit(FullNameInvalid());
    // }
    return valid;
  }

  bool checkPhone(String phone) {
    bool valid = phone.isNotEmpty;
    // if (!valid) {
    //   emit(PhoneInvalid());
    // }
    return valid;
  }

  bool checkEmail(String email) {
    bool valid = email.isNotEmpty;
    // if (!valid) {
    //   emit(EmailInvalid());
    // }
    return valid;
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: ProgressStatus.inProgress));
    final response = await repository.signOut();
    response.fold((error) {
      emit(state.copyWith(signOutStatus: ProgressStatus.failure));
    }, (data) async {
      await di<AccessTokenStorage>().delete();
      await di<UsernameStorage>().delete();
      await di<CountryStorage>().delete();
      await di<ProfileStorage>().delete();
      emit(state.copyWith(token: '', signOutStatus: ProgressStatus.success));
    });
  }

  Future<void> register({
    required String userName,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    emit(state.copyWith(registerStatus: ProgressStatus.inProgress));
    final response = await repository.register(
        userName: userName,
        password: password,
        fullName: fullName,
        phone: phone);
    response.fold((error) {
      emit(state.copyWith(registerStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
          registerStatus: ProgressStatus.success, token: data?.userName ?? ''));
    });
  }

  Future<void> verifyCode({
    required String phone,
    required String otp,
    required String email,
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String gender,
    int? month,
    int? year,
    required String country,
    required String city,
    String? referralCode,
    String? referredFrom,
    required int terms,
  }) async {
    emit(state.copyWith(signInStatus: ProgressStatus.inProgress));
    final response = await repository.verifyCode(
        param: CodeVerificationParameter(
      phone: phone,
      otp: otp,
      taskSlug: 'user_signup',
      secondParam: email,
    ));
    response.fold((error) {
      emit(state.copyWith(
          signInStatus: ProgressStatus.failure,
          errorMessage: (error as DetailFailure).message));
    }, (data) async {
      if (data.token?.isNotEmpty ?? false) {
        final response2 = await repository.createUser(
            param: UserCreationParameter(
          firstName: firstName,
          lastName: lastName,
          email: email,
          username: username,
          password: password,
          gender: gender,
          month: month,
          year: year,
          country: country,
          referralCode: referralCode,
          referredFrom: referredFrom,
          city: city,
          terms: terms,
          smsToken: data.token,
        ));
        response2.fold((error) {
          emit(state.copyWith(
              signInStatus: ProgressStatus.failure,
              errorMessage: (error as DetailFailure).message));
        }, (data2) async {
          if (data2.token?.isNotEmpty ?? false) {
            await di<AccessTokenStorage>().write(data2.token!);
            final userResponse = await userRepository.getBasicProfile();
            userResponse.fold((error) {
              emit(state.copyWith(signInStatus: ProgressStatus.failure));
            }, (user) async {
              await di<UsernameStorage>().write(user.username ?? '');
              await di<CountryStorage>().write(user.country ?? '');
              emit(state.copyWith(signInStatus: ProgressStatus.success));
            });
          } else {
            emit(state.copyWith(
                signInStatus: ProgressStatus.failure,
                errorMessage: 'token is empty'));
          }
        });
      } else {
        emit(state.copyWith(
            signInStatus: ProgressStatus.failure,
            errorMessage: 'token is empty'));
      }
    });
  }

  Future<void> forgotPassword(String userName) async {
    emit(state.copyWith(forgotPasswordStatus: ProgressStatus.inProgress));
    final response = await repository.forgotPassword(userName: userName);
    response.fold((error) {
      if (error is DetailFailure) {
        emit(state.copyWith(
          forgotPasswordStatus: ProgressStatus.failure,
          errorMessage: error.message ?? '',
        ));
      } else {
        emit(state.copyWith(
          forgotPasswordStatus: ProgressStatus.failure,
          errorMessage: 'something wrong, unknown error',
        ));
      }
    }, (data) {
      emit(state.copyWith(forgotPasswordStatus: ProgressStatus.success));
    });
  }

  @override
  Future<void> close() {
    repository.cancelRequest();
    return super.close();
  }
}
