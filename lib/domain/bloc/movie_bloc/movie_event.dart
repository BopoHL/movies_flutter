part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends MovieEvent {
  @override
  List<Object> get props => [];
}

class GetMovieDetailsEvent extends MovieEvent {
  final int id;


  @override
  List<Object> get props => [id];

  const GetMovieDetailsEvent({required this.id});
}

class SearchMoviesEvent extends MovieEvent {
  final String query;

  @override
  List<Object> get props => [query];

  const SearchMoviesEvent({required this.query});
}
