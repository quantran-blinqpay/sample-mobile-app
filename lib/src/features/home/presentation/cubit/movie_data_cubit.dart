import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/core/utils/datetime.dart';
import 'package:qwid/src/features/home/domain/models/movie.dart';
import 'package:qwid/src/features/home/domain/repositories/movie_repository.dart';

part 'movie_data_state.dart';

class MovieDataCubit extends Cubit<MovieDataState> {
  MovieDataCubit(this.repository) : super(MovieDataInitial());

  final MovieRepository repository;

  Future<void> getTopPage() async {
    emit(MovieDataLoading());
    final response = await repository.getTopPage(DateTimeUtil.formatDateNow());
    response.fold((error) {
      emit(MovieDataFailure());
    }, (data) {
      emit(MovieDataLoaded(data));
    });
  }
}
