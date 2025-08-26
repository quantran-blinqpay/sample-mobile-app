import 'package:json_annotation/json_annotation.dart';

part 'error_entity.g.dart';

@JsonSerializable()
class ErrorEntity {
  @JsonKey()
  String field;
  @JsonKey()
  String location;
  @JsonKey()
  List<String> messages;

  ErrorEntity(
      {required this.field, required this.location, required this.messages});

  factory ErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$ErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorEntityToJson(this);
}

//  “errors”: [
//         {
//             “field”: “authorization”,
//             “location”: “header”,
//             “messages”: [
//                 “INVALID_TOKEN”
//             ]
//         }
//     ]
