import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDTO extends Equatable {
  @JsonKey(name: 'is_card')
  final bool? isCard;
  @JsonKey()
  final int? point;
  @JsonKey(name: 'forget_password_token')
  final String? forgetPasswordToken;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey()
  final String? phone;
  @JsonKey(name: 'fullname')
  final String? fullName;
  @JsonKey(name: 'bar_code')
  final String? barCode;
  @JsonKey(name: '_id')
  final String? id;

  const ProfileDTO({
    this.isCard,
    this.point,
    this.forgetPasswordToken,
    this.v,
    this.phone,
    this.fullName,
    this.barCode,
    this.id,
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> json) {
    return _$ProfileDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileDTOToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [isCard, point, forgetPasswordToken, v, phone, fullName, barCode, id];

  ProfileDTO copyWith({
    bool? isCard,
    int? point,
    String? forgetPasswordToken,
    int? v,
    String? phone,
    String? fullName,
    String? barCode,
    String? id,
  }) {
    return ProfileDTO(
      isCard: isCard ?? this.isCard,
      point: point ?? this.point,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      v: v ?? this.v,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      barCode: barCode ?? this.barCode,
      id: id ?? this.id,
    );
  }
}
