abstract final class AppConstants {
  static const String appName    = 'REENA AI Kitchen';
  static const String version    = '1.0.0-s003';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL', defaultValue: 'http://localhost:3001');
  static const String householdServiceUrl = String.fromEnvironment(
    'HOUSEHOLD_SERVICE_URL', defaultValue: 'http://localhost:3002');
  static const String pantryServiceUrl = String.fromEnvironment(
    'PANTRY_SERVICE_URL', defaultValue: 'http://localhost:3003');
  static const String recipeServiceUrl = String.fromEnvironment(
    'RECIPE_SERVICE_URL', defaultValue: 'http://localhost:3004');

  // Routes
  static const String routeSplash      = '/';
  static const String routeLogin       = '/login';
  static const String routeRegister    = '/register';
  static const String routeOnboarding  = '/onboarding';
  static const String routeHome        = '/home';
  static const String routeRecipeDetail= '/recipes/:id';
  static const String routeCooking     = '/cooking/:id';
  static const String routePlanner     = '/planner';

  // Storage keys
  static const String keyAccessToken    = 'reena.auth.token.v1';
  static const String keyOnboardingDone = 'reena.onboarding.done.v1';
  static const String keyUserEmail      = 'reena.user.email.v1';
  static const String keyUserName       = 'reena.user.name.v1';
  static const String keyHouseholdId    = 'reena.household.id.v1';
  static const String keyMealPlan       = 'reena.meal_plan.v1';
  static const String keyMealHistory    = 'reena.meal_history.v1';
}
