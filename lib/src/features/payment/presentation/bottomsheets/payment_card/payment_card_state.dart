part of 'payment_card_cubit.dart';

class PaymentCardState extends Equatable {
  final String? cardNumber;
  final String? expiredDate;
  final String? securityCode;
  final String? nameOnCard;
  final ProgressStatus? submitCreditCardStatus;
  final WindcaveCardData? creditCard;
  final ProgressStatus? getClientTokenStatus;
  final String? clientToken;
  final String? href;
  final String? temporaryToken;
  final WindcaveCardData? temporaryCreditCard;

  @override
  List<Object?> get props => [
        cardNumber,
        expiredDate,
        securityCode,
        nameOnCard,
        submitCreditCardStatus,
        creditCard,
        getClientTokenStatus,
        clientToken,
        href,
        temporaryToken,
        temporaryCreditCard
  ];

  const PaymentCardState({
    this.cardNumber,
    this.expiredDate,
    this.securityCode,
    this.nameOnCard,
    this.submitCreditCardStatus,
    this.creditCard,
    this.getClientTokenStatus,
    this.clientToken,
    this.href,
    this.temporaryToken,
    this.temporaryCreditCard,
  });

  PaymentCardState copyWith({
    String? cardNumber,
    String? expiredDate,
    String? securityCode,
    String? nameOnCard,
    ProgressStatus? submitCreditCardStatus,
    WindcaveCardData? creditCard,
    ProgressStatus? getClientTokenStatus,
    String? clientToken,
    String? href,
    String? temporaryToken,
    WindcaveCardData? temporaryCreditCard,
  }) {
    return PaymentCardState(
      cardNumber: cardNumber ?? this.cardNumber,
      expiredDate: expiredDate ?? this.expiredDate,
      securityCode: securityCode ?? this.securityCode,
      nameOnCard: nameOnCard ?? this.nameOnCard,
      submitCreditCardStatus:
          submitCreditCardStatus ?? this.submitCreditCardStatus,
      creditCard: creditCard ?? this.creditCard,
      getClientTokenStatus: getClientTokenStatus ?? this.getClientTokenStatus,
      clientToken: clientToken ?? this.clientToken,
      href: href ?? this.href,
      temporaryToken: temporaryToken ?? this.temporaryToken,
      temporaryCreditCard: temporaryCreditCard ?? this.temporaryCreditCard,
    );
  }
}
