import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_flutter/domain/bloc/movie_bloc/movie_bloc.dart';
import 'package:movies_flutter/ui/components/rating_widget.dart';
import 'package:movies_flutter/ui/go_router/app_routes.dart';
import 'package:movies_flutter/ui/theme/app_styles.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MovieBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              bloc.add(GetPopularMoviesEvent());
              context.goNamed(AppRoutes.home);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsLoaded) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      opacity: 0.3,
                      image: CachedNetworkImageProvider(
                          'https://image.tmdb.org/t/p/original${state.movie.backdropPath!}'))),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${state.movie.posterPath!}'),
                  const SizedBox(height: 10),
                  Text(
                    state.movie.title!,
                    style: AppTextStyle.title,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.movie.releaseDate!,
                          style: AppTextStyle.description,
                          textAlign: TextAlign.center),
                      const SizedBox(width: 10),
                      RatingWidget(voteAverage: state.movie.voteAverage!),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(state.movie.tagline!,
                      style: AppTextStyle.title.copyWith(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text(
                    state.movie.overview!,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.title
                        .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
