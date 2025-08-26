part of 'movie_data_cubit.dart';

abstract class MovieDataState extends Equatable {
  const MovieDataState();

  @override
  List<Object> get props => [];
}

class MovieDataInitial extends MovieDataState {}

class MovieDataLoading extends MovieDataState {}

class MovieDataLoaded extends MovieDataState {
  final List<MovieModel> data;

  const MovieDataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class MovieDataFailure extends MovieDataState {}
