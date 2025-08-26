import 'package:designerwardrobe/src/core/network/response/object_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/login_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register_dto.dart';
import 'package:designerwardrobe/src/features/authentication/domain/model/auth_mapper.dart';
import '../model/register.dart';

class RegisterMapper {
  static RegisterModel? mapToModel(ObjectResponse<RegisterDTO> response) {
    return response.data?.toModel();
  }
}

class SignInMapper {
  static String mapToModel(LoginResponse response) {
    return response.token ?? '';
  }
}
