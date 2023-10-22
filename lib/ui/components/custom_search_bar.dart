import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/movie_bloc/movie_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MovieBloc>();
    return AppBar(
      title: TextField(
          decoration: InputDecoration(border: UnderlineInputBorder()),
          controller: searchController,
          onSubmitted: (_) {
            if (searchController.text.isEmpty) {
              bloc.add(GetPopularMoviesEvent());
            } else {
              bloc.add(SearchMoviesEvent(query: searchController.text));
            }
          }),
    );
  }
}
