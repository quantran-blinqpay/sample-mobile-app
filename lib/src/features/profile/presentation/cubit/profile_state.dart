// ignore_for_file: must_be_immutable

part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profile,
    this.dataDrafts,
    this.fetchUserProfileStatus = ProgressStatus.initial,
    this.fetchDraftsStatus = ProgressStatus.initial,
    this.fetchDetailStatus = ProgressStatus.initial,
  });

  final UserData? profile;
  final List<GetDraftsResponseDatum>? dataDrafts;
  final ProgressStatus fetchUserProfileStatus;
  final ProgressStatus fetchDraftsStatus;
  final ProgressStatus fetchDetailStatus;

  @override
  List<Object?> get props => [
        profile,
        dataDrafts,
        fetchUserProfileStatus,
        fetchDraftsStatus,
        fetchDetailStatus,
      ];

  ProfileState copyWith({
    UserData? profile,
    List<GetDraftsResponseDatum>? dataDrafts,
    ProgressStatus? fetchUserProfileStatus,
    ProgressStatus? fetchDraftsStatus,
    ProgressStatus? fetchDetailStatus,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      dataDrafts: dataDrafts ?? this.dataDrafts,
      fetchUserProfileStatus:
          fetchUserProfileStatus ?? this.fetchUserProfileStatus,
      fetchDraftsStatus: fetchDraftsStatus ?? this.fetchDraftsStatus,
      fetchDetailStatus: fetchDetailStatus ?? this.fetchDetailStatus,
    );
  }
}
