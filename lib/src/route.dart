import 'package:flutter/material.dart';

import 'pages/pages.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AuthPage());
    case '/mq':
      final args = settings.arguments as MQArgs;
      return MaterialPageRoute(builder: (_) => MQPage(data: args.data));
    case '/search':
      final args = settings.arguments as SearchArgs;
      return MaterialPageRoute(builder: (_) => SearchPage(data: args.data));
    case '/aladhan':
      final args = settings.arguments as AlAdhanArgs;
      return MaterialPageRoute(
          builder: (_) => AlAdhanPage(addressIP: args.addressIP));
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
