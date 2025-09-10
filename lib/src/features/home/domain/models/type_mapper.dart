
import 'package:qwid/src/features/home/data/remote/dtos/type_dto.dart';
import 'package:qwid/src/features/home/domain/models/type.dart';

extension TypeData on TypeDto {
  TypeModel toModel() => TypeModel(id: id, code: code, name: name, v: v);
}