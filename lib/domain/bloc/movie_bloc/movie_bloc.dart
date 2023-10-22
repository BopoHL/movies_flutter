import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_flutter/domain/api/api.dart';
import 'package:movies_flutter/domain/models/movie_list.dart';
import '../../models/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movieList = await Api.getPopularMovies();
        emit(MovieListLoaded(movieList: movieList));
      } catch (e) {
        emit(MovieError(message: 'Failed to get popular $e'));
      }
    });
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movie = await Api.getMovieInfo(event.id);
        emit(MovieDetailsLoaded(movie: movie));
      } catch (e) {
        emit(MovieError(message: 'Failed to get details $e'));
      }
    });
    on<SearchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movieList = await Api.searchMovies(event.query);
        emit(MovieListLoaded(movieList: movieList));
      } catch (e) {
        emit(MovieError(message: 'Failed to search $e'));
      }
    });
  }
}
