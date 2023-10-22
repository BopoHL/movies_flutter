import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_flutter/domain/bloc/movie_bloc/movie_bloc.dart';
import 'package:movies_flutter/ui/go_router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieBloc()..add(GetPopularMoviesEvent()),
      child: MaterialApp.router(
        theme: ThemeData.dark(useMaterial3: false),
        routerConfig: Routes.routes,
      ),
    );
  }
}
