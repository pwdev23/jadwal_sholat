import 'common.dart';
import 'route.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Sholat',
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.prayerSchedule,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
