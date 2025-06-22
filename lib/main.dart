import 'package:flutter/material.dart';
import 'package:shamoapps/src/generated/i18n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shamoapps/core/theme/custom_app_theme.dart';
import 'package:shamoapps/routes/app_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute.routeHandler,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: CustomAppTheme.kRaisinBlackSecond,
          seedColor: CustomAppTheme.kRaisinBlackSecond,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
    );
  }
}
