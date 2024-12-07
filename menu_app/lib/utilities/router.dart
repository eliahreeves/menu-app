import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/views/about_page.dart';
import 'package:menu_app/views/calculator.dart';
import 'package:menu_app/views/home_page.dart';
import 'package:menu_app/views/settings_page.dart';
import 'package:menu_app/views/hall_page.dart';

// GoRouter configuration
final goRouter = GoRouter(
  initialLocation: '/',
  observers: [
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  routes: [
    GoRoute(
        name: 'Home',
        path: '/',
        builder: (context, state) {
          return const HomePage();
        }),
    GoRoute(
      name: 'Merrill',
      path: '/Merrill',
      builder: (context, state) =>
          const MenuPage(name: "Merrill", hasLateNight: false),
    ),
    GoRoute(
      name: 'Cowell',
      path: '/Cowell',
      builder: (context, state) =>
          const MenuPage(name: "Cowell", hasLateNight: true),
    ),
    GoRoute(
      name: 'Nine',
      path: '/Nine',
      builder: (context, state) =>
          const MenuPage(name: "Nine", hasLateNight: true),
    ),
    GoRoute(
      name: 'Porter',
      path: '/Porter',
      builder: (context, state) =>
          const MenuPage(name: "Porter", hasLateNight: true),
    ),
    GoRoute(
      name: 'Oakes',
      path: '/Oakes',
      builder: (context, state) => const MenuPage(
          name: "Oakes", hasLateNight: true), // FIXME change to Carson
    ),
    // GoRoute(
    //   name: 'Nutrition',
    //   path: '/Nutrition',
    //   builder: (BuildContext context, GoRouterState state) {
    //     final foodItem = state.extra as FoodItem;
    //     return NutritionPage(foodItem: foodItem);
    //   },
    // ),
    GoRoute(
      name: 'Calculator',
      path: '/Calculator',
      builder: (context, state) => const Calculator(),
    ),
    GoRoute(
      name: 'Settings',
      path: '/Settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: 'About',
      path: '/About',
      builder: (context, state) => const AboutPage(),
    ),
  ],
);
