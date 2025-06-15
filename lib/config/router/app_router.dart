import 'package:go_router/go_router.dart';
import 'package:reto_pragma/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/breed_detail', builder: (context, state) {
      final breedId = state.extra as String;
      return BreedDetailScreen(breedId: breedId);
    })
  ]
);