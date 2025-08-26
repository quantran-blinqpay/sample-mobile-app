import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/parameters/counter_offer_parameter.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/parameters/make_offer_parameter.dart';
import 'package:designerwardrobe/src/features/home/presentation/dialogs/make_offer.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/home_repository.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this.repository) : super(OfferState());

  final HomeRepository repository;

  void updateIsCustomSelected(bool isCustomSelected) {
    emit(state.copyWith(isCustomSelected: isCustomSelected));
  }

  void updateCurrency(String currency) {
    emit(state.copyWith(currency: currency));
  }

  void updatePrice(String price) {
    emit(state.copyWith(price: price));
  }

  void updateListingId(int listingId) {
    emit(state.copyWith(listingId: listingId));
  }

  void updateListingOfferId(int listingOfferId) {
    emit(state.copyWith(listingOfferId: listingOfferId));
  }

  void updateSelectedId(int id) {
    emit(state.copyWith(selectedId: id));
  }

  Future<void> makeOffer() async {
    emit(state.copyWith(makeOfferStatus: ProgressStatus.inProgress));
    final response = await repository.makeOffer(MakeOfferParameter(
      listingId: state.listingId ?? -1,
      currency: state.currency ?? '',
      price: state.price ?? '',
    ));
    response.fold((error) {
      emit(state.copyWith(makeOfferStatus: ProgressStatus.failure, errorMessage: (error as DetailFailure).message));
    }, (data) {
      emit(state.copyWith(
        makeOfferStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> counterOffer(bool isSeller) async {
    emit(state.copyWith(counterOfferStatus: ProgressStatus.inProgress));
    final response = await repository.counterOffer(CounterOfferParameter(
      listingId: state.listingId ?? -1,
      currency: state.currency ?? '',
      price: state.price ?? '',
      listingOfferId: state.listingOfferId ?? -1,
      excludesShippingForwarding: isSeller ? 1 : 0,
    ));
    response.fold((error) {
      emit(state.copyWith(
        counterOfferStatus: ProgressStatus.failure,
        errorMessage: (error as DetailFailure).message));
    }, (data) {
      emit(state.copyWith(
        counterOfferStatus: ProgressStatus.success,
      ));
    });
  }

  @override
  Future<void> close() {
    // Emit a clean initial state before closing
    emit(OfferState());
    return super.close();
  }
}
