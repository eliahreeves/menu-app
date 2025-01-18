import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_app/views/about_page.dart';
import 'package:menu_app/views/calculator_page.dart';
import 'package:menu_app/views/home_page.dart';
import 'package:menu_app/views/settings_page.dart';
import 'package:menu_app/views/hall_page.dart';
import 'package:menu_app/utilities/constants.dart' as c;

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
      name: c.Colleges.merrill.name,
      path: c.Colleges.merrill.pathName,
      builder: (context, state) => const MenuPage(
        college: c.Colleges.merrill,
      ),
    ),
    GoRoute(
      name: c.Colleges.cowell.name,
      path: c.Colleges.cowell.pathName,
      builder: (context, state) => const MenuPage(college: c.Colleges.cowell),
    ),
    GoRoute(
      name: c.Colleges.nine.name,
      path: c.Colleges.nine.pathName,
      builder: (context, state) => const MenuPage(college: c.Colleges.nine),
    ),
    GoRoute(
      name: c.Colleges.porter.name,
      path: c.Colleges.porter.pathName,
      builder: (context, state) => const MenuPage(college: c.Colleges.porter),
    ),
    GoRoute(
      name: c.Colleges.oakes.name,
      path: c.Colleges.oakes.pathName,
      builder: (context, state) => const MenuPage(
        college: c.Colleges.oakes,
      ), // FIXME change to Carson
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
