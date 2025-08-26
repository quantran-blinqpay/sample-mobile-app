import 'package:json_annotation/json_annotation.dart';

part 'submit_credit_card_parameter.g.dart';

@JsonSerializable()
class SubmitCreditCardParameter {
  @JsonKey()
  final CardInfo? card;

  SubmitCreditCardParameter({this.card});

  factory SubmitCreditCardParameter.fromJson(Map<String, dynamic> json) => _$SubmitCreditCardParameterFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitCreditCardParameterToJson(this);
}

@JsonSerializable()
class CardInfo {
  @JsonKey()
  final String? dateExpiryMonth;

  @JsonKey()
  final String? cardNumber;

  @JsonKey()
  final String? dateExpiryYear;

  @JsonKey()
  final String? cvc2;

  CardInfo({
    this.dateExpiryMonth,
    this.cardNumber,
    this.dateExpiryYear,
    this.cvc2,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) => _$CardInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CardInfoToJson(this);

  @override
  String toString() {
    return '{dateExpiryMonth: $dateExpiryMonth, cardNumber: $cardNumber, dateExpiryYear: $dateExpiryYear, cvc2: $cvc2}';
  }
}