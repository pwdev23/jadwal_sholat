import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart' show HomeArgs;

class AuthPage extends StatefulWidget {
  static const routeName = '/';

  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();

    final nav = Navigator.of(context);

    _checkState(
      onEmpty: (_) => nav.pushReplacementNamed('/search'),
      onCityId: (id) =>
          nav.pushReplacementNamed('/home', arguments: HomeArgs('Home', id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _checkState({
    required Function(String) onEmpty,
    required Function(String) onCityId,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('cityId') == null) {
      onEmpty('n/a');
    } else {
      var cityId = prefs.getString('cityId')!;
      onCityId(cityId);
    }
  }
}
