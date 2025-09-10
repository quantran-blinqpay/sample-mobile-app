import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/features/home/domain/models/movie.dart';

part 'movie_selector_state.dart';

class MovieSelectorCubit extends Cubit<MovieSelectorState> {
  MovieSelectorCubit() : super(MovieSelectorInitial());

  void onSelected(int index, MovieModel movie) {
    emit(MovieSelectorSelected(index, movie));
  }

  void unSelected() {
    emit(MovieSelectorUnSelected());
  }
}
