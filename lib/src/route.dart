import 'package:flutter/material.dart';

import 'pages/pages.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AuthPage());
    case '/home':
      final args = settings.arguments as HomeArgs;
      return MaterialPageRoute(
          builder: (_) => HomePage(title: args.title, cityId: args.cityId));
    case '/search':
      return MaterialPageRoute(builder: (_) => const SearchPage());
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
