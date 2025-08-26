import 'package:json_annotation/json_annotation.dart';

part 'submit_credit_card_response.g.dart';

@JsonSerializable()
class SubmitCreditCardResponse {
  final String? id;
  final List<PaymentLink>? links;

  SubmitCreditCardResponse({
    this.id,
    this.links,
  });

  factory SubmitCreditCardResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitCreditCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitCreditCardResponseToJson(this);
}

@JsonSerializable()
class PaymentLink {
  final String? href;
  final String? rel;
  final String? method;

  PaymentLink({
    this.href,
    this.rel,
    this.method,
  });

  factory PaymentLink.fromJson(Map<String, dynamic> json) =>
      _$PaymentLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
}