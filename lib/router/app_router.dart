import 'package:compliments_app/router/screen_routes.dart';
import 'package:go_router/go_router.dart';

import '../models/compliment_model.dart';
import '../screens/home_screen.dart';
import '../screens/new_compliment.dart';
import '../screens/share_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: ScreenRoutes.home,
    routes: [
      GoRoute(
        path: ScreenRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: ScreenRoutes.newCompliment,
        builder: (context, state) => const NewCompliment(),
      ),
      GoRoute(
        path: ScreenRoutes.share,
        builder: (context, state) {
          final compliment = state.extra as Compliment;
          return ShareScreen(compliment: compliment);
        },
      ),
    ],
  );
}
