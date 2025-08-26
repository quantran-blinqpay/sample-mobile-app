import 'package:bloc/bloc.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/country/local_country.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/parameters/create_address_parameter.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/parameters/lookup_address_parameter.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/create_address_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/lookup_address_response.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_address_state.dart';

class PaymentAddressCubit extends Cubit<PaymentAddressState> {
  PaymentAddressCubit(this.repository) : super(PaymentAddressState());
  final PaymentRepository repository;

  void loadLocalCountries(List<LocalCountry> countries){
    emit(state.copyWith(localCountries: countries));
  }

  void updateCountry(LocalCountry country){
    emit(state.copyWith(country: country));
  }

  void updateFirstName(String firstName){
    emit(state.copyWith(firstName: firstName));
  }

  void updateLastName(String lastName){
    emit(state.copyWith(lastName: lastName));
  }

  void updateCompany(String company){
    emit(state.copyWith(company: company));
  }

  void updateAddress(String address){
    emit(state.copyWith(address: address));
  }

  void selectAddress(AddressItem? address){
    emit(state.copyWith(selectedAddress: address));
  }

  void updatePhone(String phone){
    emit(state.copyWith(phone: phone));
  }

  void updatePhoneCode(String phoneCode){
    emit(state.copyWith(phone: phoneCode));
  }

  Future<void> lookupAddress() async {
    try {
      emit(state.copyWith(lookupAddressStatus: ProgressStatus.inProgress));
      final response = await repository.lookupAddress(parameter: LookupAddressParameter(
        countryCode: state.country?.countryName == 'Australia' ? 'AU' : 'NZ',
        query: state.address,
      ));
      response.fold((error) {
        emit(state.copyWith(lookupAddressStatus: ProgressStatus.failure));
      }, (data) {
        emit(state.copyWith(
          suggestions: data?.addresses ?? [],
          lookupAddressStatus: ProgressStatus.success,
        ));
      });
    } catch (e) {
      emit(state.copyWith(lookupAddressStatus: ProgressStatus.failure));
    }
  }

  Future<void> createAddress() async {
    try {
      emit(state.copyWith(createAddressStatus: ProgressStatus.inProgress));
      final response = await repository.createAddress(
          parameter: CreateAddressParameter(
            addressId: state.selectedAddress?.addressId,
            newAddressDeliverTo: '${state.firstName} ${state.lastName}',
            allowPickups: false,
            newAddressCompany: state.company,
            newAddress: state.selectedAddress?.fullAddress,
          ),
      );
      response.fold((error) {
        emit(state.copyWith(createAddressStatus: ProgressStatus.failure));
      }, (data) {
        emit(state.copyWith(
          addressResponse: data,
          createAddressStatus: ProgressStatus.success,
        ));
      });
    } catch (e) {
      emit(state.copyWith(createAddressStatus: ProgressStatus.failure));
    }
  }

}
