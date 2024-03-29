import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mq_page.dart' show MQArgs;
import 'search_page.dart' show SearchArgs;

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
      onEmpty: (d) =>
          nav.pushReplacementNamed('/search', arguments: SearchArgs(d)),
      onData: (d) => nav.pushReplacementNamed('/mq',
          arguments: MQArgs(d)),
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
    required Function(String) onData,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('data') == null) {
      var initData = {
        "cityId": "1301",
        "notifications": {
          "imsak": false,
          "fajr": false,
          "sunrise": false,
          "dhuha": false,
          "dhuhr": false,
          "asr": false,
          "maghrib": false,
          "isha": false,
        }
      };

      final data = json.encode(initData);

      prefs.setString('data', data);

      onEmpty(data);
    } else {
      var data = prefs.getString('data')!;
      onData(data);
    }
  }
}
