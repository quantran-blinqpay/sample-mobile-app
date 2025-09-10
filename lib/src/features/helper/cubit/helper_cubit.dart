import 'package:qwid/src/features/helper/dtos/currency_rate_response.dart';
import 'package:qwid/src/features/helper/dtos/get_startup_response.dart';
import 'package:qwid/src/features/helper/respositories/helper_repository.dart';
import 'package:qwid/src/features/helper/dtos/site_setting_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit(this.repository) : super(HelperState());

  final HelperRepository repository;

  Future<void> initData() async {
    loadStartupList();
    loadAllSiteSettings();
    getCurrencyRate();
  }

  Future<void> loadStartupList() async {
    final response = await repository.loadStartup();
    response.fold((error) {
      debugPrint('loadStartupList error ${error.toString()}');
    }, (data) {
      emit(state.copyWith(startup: data));
    });
  }

  Future<void> loadAllSiteSettings() async {
    final response = await repository.loadAllSiteSettings();
    response.fold((error) {
      debugPrint('loadAllSiteSettings error: ${error.toString()}');
    }, (data) {
      emit(state.copyWith(siteSetting: data));
    });
  }

  Future<void> getCurrencyRate() async {
    final response = await repository.getCurrencyRate();
    response.fold((error) {
      debugPrint('getCurrencyRate error ${error.toString()}');
    }, (data) {
      emit(state.copyWith(currencyRate: data));
    });
  }

  @override
  Future<void> close() {
    super.emit(HelperState());
    return super.close();
  }
}
