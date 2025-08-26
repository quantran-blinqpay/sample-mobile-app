part of 'movie_selector_cubit.dart';

abstract class MovieSelectorState extends Equatable {
  const MovieSelectorState();

  @override
  List<Object> get props => [];
}

class MovieSelectorInitial extends MovieSelectorState {}

class MovieSelectorSelected extends MovieSelectorState {
  final int index;
  final MovieModel movie;

  const MovieSelectorSelected(this.index, this.movie);

  @override
  List<Object> get props => [index];
}

class MovieSelectorUnSelected extends MovieSelectorState {}
