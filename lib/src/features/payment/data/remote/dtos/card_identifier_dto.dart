import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_identifier_dto.g.dart';

@JsonSerializable()
class CardIdentifierDto {
  @JsonKey()
  final String? last4Digits;
  @JsonKey()
  final String? prefix;
  @JsonKey()
  final String? cardType;
  @JsonKey()
  final int? id;

  CardIdentifierDto({this.id, this.cardType, this.prefix, this.last4Digits});

  factory CardIdentifierDto.fromJson(Map<String, dynamic> json) => _$CardIdentifierDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CardIdentifierDtoToJson(this);

}