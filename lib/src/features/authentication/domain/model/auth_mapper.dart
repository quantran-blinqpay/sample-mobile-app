import 'package:qwid/src/features/authentication/data/remote/dtos/register_dto.dart';
import 'package:qwid/src/features/authentication/domain/model/register.dart';

extension RegisterData on RegisterDTO {
  RegisterModel toModel() =>
      RegisterModel(userName: userName, password: password);
}
