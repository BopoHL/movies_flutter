import 'package:go_router/go_router.dart';
import 'package:movies_flutter/ui/go_router/app_routes.dart';
import 'package:movies_flutter/ui/pages/details_page/details_page.dart';
import 'package:movies_flutter/ui/pages/search_page/search_page.dart';

class Routes {
  static final _routes = GoRouter(routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: AppRoutes.details,
      name: AppRoutes.details,
      builder: (context, state) => const DetailsPage(),
    ),
  ]);

  static GoRouter get routes => _routes;
}
