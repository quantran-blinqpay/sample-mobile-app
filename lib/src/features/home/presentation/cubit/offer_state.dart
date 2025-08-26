part of 'offer_cubit.dart';

class OfferState extends Equatable {
  const OfferState({
    this.makeOfferStatus = ProgressStatus.initial,
    this.counterOfferStatus = ProgressStatus.initial,
    this.errorMessage,
    this.currency,
    this.price,
    this.listingId,
    this.isCustomSelected,
    this.listingOfferId,
    this.selectedId,
  });
  
  final ProgressStatus makeOfferStatus;
  final ProgressStatus counterOfferStatus;
  final String? errorMessage;
  final String? currency;
  final String? price;
  final int? listingId;
  final bool? isCustomSelected;
  final int? listingOfferId;
  final int? selectedId;

  @override
  List<Object ?> get props => [
    makeOfferStatus,
    counterOfferStatus,
    errorMessage,
    currency,
    price,
    listingId,
    isCustomSelected,
    listingOfferId,
    selectedId,
  ];

  OfferState copyWith({
    ProgressStatus? makeOfferStatus,
    ProgressStatus? counterOfferStatus,
    String? errorMessage,
    String? currency,
    String? price,
    int? listingId,
    bool? isCustomSelected,
    int? listingOfferId,
    int? selectedId,
  }) {
    return OfferState(
      makeOfferStatus: makeOfferStatus ?? this.makeOfferStatus,
      counterOfferStatus: counterOfferStatus ?? this.counterOfferStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      currency: currency ?? this.currency,
      price: price ?? this.price,
      listingId: listingId ?? this.listingId,
      isCustomSelected: isCustomSelected ?? this.isCustomSelected,
      listingOfferId: listingOfferId ?? this.listingOfferId,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
