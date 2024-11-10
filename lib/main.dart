import 'package:compliments_app/models/compliment_model.dart';
import 'package:compliments_app/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/share_screen.dart';
import 'screens/new_compliment.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Compliments App',
    );
  }
}
