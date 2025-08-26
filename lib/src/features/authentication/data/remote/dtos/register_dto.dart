import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDTO extends Equatable {
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey()
  final String password;
  @JsonKey(name: 'fullname')
  final String fullName;
  @JsonKey()
  final String phone;

  const RegisterDTO(
      {required this.userName,
      required this.password,
      required this.fullName,
      required this.phone});

  factory RegisterDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [userName, password, fullName, phone];

  RegisterDTO copyWith({
    String? userName,
    String? password,
    String? fullName,
    String? phone,
  }) {
    return RegisterDTO(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }
}
