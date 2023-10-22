import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_flutter/ui/components/rating_widget.dart';
import 'package:movies_flutter/ui/go_router/app_routes.dart';
import 'package:movies_flutter/ui/theme/app_colors.dart';
import 'package:movies_flutter/ui/theme/app_styles.dart';
import '../../../domain/bloc/movie_bloc/movie_bloc.dart';
import '../../../domain/models/genres.dart';
import '../../components/custom_search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MovieBloc>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, 80), child: CustomSearchBar()),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieListLoaded) {
            var movieList = state.movieList.results;
            // var genreList = state.genreList.genres;
            return ListView.separated(
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movieList![i].posterPath}',
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                const ColoredBox(color: AppColors.greyMenu),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movieList[i].title!,
                                  style: AppTextStyle.title),
                              for (var id in movieList[i].genreIds!)
                                Text('${Genres.genres[id]}'),
                              Text(movieList[i].releaseDate!,
                                  style: AppTextStyle.description),
                              RatingWidget(
                                  voteAverage: movieList[i].voteAverage),
                              ElevatedButton(
                                onPressed: () {
                                  bloc.add(GetMovieDetailsEvent(id: movieList[i].id!));
                                  context.goNamed(AppRoutes.details);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: AppColors.greyMenu,
                                  foregroundColor: AppColors.yellow,
                                ),
                                child: const Text('Подробнее'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) => Container(
                height: 1,
                color: AppColors.yellow,
              ),
              itemCount: state.movieList.results!.length,
            );
          } else if (state is MovieError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
