import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/cooking/presentation/cooking_journey_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/meal_planner/presentation/meal_planner_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/recipe/presentation/recipe_detail_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../constants/app_constants.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(authRouterNotifierProvider);

  return GoRouter(
    initialLocation: AppConstants.routeSplash,
    refreshListenable: notifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authProvider);
      final loc = state.matchedLocation;

      if (authState.isLoading) {
        return loc == AppConstants.routeSplash ? null : AppConstants.routeSplash;
      }
      if (authState.isAuthenticated) {
        if (loc == AppConstants.routeSplash ||
            loc == AppConstants.routeLogin ||
            loc == AppConstants.routeRegister) {
          return AppConstants.routeHome;
        }
        return null;
      }
      if (loc == AppConstants.routeHome ||
          loc == AppConstants.routePlanner ||
          loc.startsWith('/recipes/') ||
          loc.startsWith('/cooking/')) {
        return AppConstants.routeLogin;
      }
      if (loc == AppConstants.routeSplash) return AppConstants.routeLogin;
      return null;
    },
    routes: [
      GoRoute(path: AppConstants.routeSplash,
          builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppConstants.routeLogin,
          builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppConstants.routeRegister,
          builder: (_, __) => const RegisterScreen()),
      GoRoute(path: AppConstants.routeOnboarding,
          builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: AppConstants.routeHome,
          builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: AppConstants.routeRecipeDetail,
        builder: (_, state) =>
            RecipeDetailScreen(recipeId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppConstants.routeCooking,
        builder: (_, state) =>
            CookingJourneyScreen(recipeId: state.pathParameters['id']!),
      ),
      GoRoute(path: AppConstants.routePlanner,
          builder: (_, __) => const MealPlannerScreen()),
    ],
  );
});
