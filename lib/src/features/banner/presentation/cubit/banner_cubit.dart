import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/configs/app_configs/app_config.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/banner/domain/models/banner.dart';
import 'package:designerwardrobe/src/features/banner/domain/repositories/banner_repository.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this.repository) : super(BannerInitial());
  final BannerRepository repository;

  Future<void> getBanner() async {
    emit(BannerLoading());
    final response = await repository.getBanner();
    response.fold((error) {
      emit(BannerFailure());
    }, (data) {
      data = data
        ..removeWhere((e) => e.disabled == true)
        ..forEach((e) => e.url = '${di<AppConfig>().baseUrl}${(e.url ?? '')}');
      emit(BannerSuccess(data));
    });
  }
}
