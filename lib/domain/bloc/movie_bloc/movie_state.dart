part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieListLoaded extends MovieState {
  final MovieList movieList;
  const MovieListLoaded({required this.movieList});
  @override
  List<Object> get props => [movieList];
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;
  const MovieDetailsLoaded({required this.movie});
  @override
  List<Object> get props => [movie];
}

class MovieError extends MovieState {
  final String message;
  const MovieError({required this.message});
  @override
  List<Object> get props => [];
}
