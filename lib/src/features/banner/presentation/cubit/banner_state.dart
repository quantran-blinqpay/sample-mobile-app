part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final List<BannerModel> data;

  const BannerSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BannerFailure extends BannerState {}
