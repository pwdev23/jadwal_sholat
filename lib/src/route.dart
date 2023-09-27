import 'package:flutter/material.dart';

import 'pages/pages.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AuthPage());
    case '/schedule':
      final args = settings.arguments as PrayerScheduleArgs;
      return MaterialPageRoute(
          builder: (_) => PrayerSchedulePage(data: args.data));
    case '/search':
      final args = settings.arguments as SearchArgs;
      return MaterialPageRoute(builder: (_) => SearchPage(data: args.data));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
