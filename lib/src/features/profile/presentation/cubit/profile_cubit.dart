import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/get_drafts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/user_data.dart';
import 'package:designerwardrobe/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(ProfileState());

  final ProfileRepository repository;

  Future<void> getMyProfile() async {
    emit(state.copyWith(fetchUserProfileStatus: ProgressStatus.inProgress));
    final response = await repository.getMyProfile();
    response.fold((error) {
      emit(state.copyWith(fetchUserProfileStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        profile: data,
        fetchUserProfileStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> getDrafts() async {
    emit(state.copyWith(fetchDraftsStatus: ProgressStatus.inProgress));
    final response = await repository.getDrafts(1, "Sizes,User,PrimaryImage");
    response.fold((error) {
      emit(state.copyWith(fetchDraftsStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataDrafts: data?.data,
        fetchDraftsStatus: ProgressStatus.success,
      ));
    });
  }

  Future<ListingDetailResponseData?> getListingDetail(int id) async {
    ListingDetailResponseData? dataReturn;
    emit(state.copyWith(fetchDetailStatus: ProgressStatus.inProgress));
    final response = await repository.getListingDetail(id);
    response.fold((error) {
      emit(state.copyWith(fetchDetailStatus: ProgressStatus.failure));
    }, (data) {
      dataReturn = data?.data;
      emit(state.copyWith(fetchDetailStatus: ProgressStatus.success));
    });

    return dataReturn;
  }

  @override
  Future<void> close() {
    repository.cancelRequest();
    return super.close();
  }
}
