import 'package:cattle_track/providers/cattle_provider.dart';
import 'package:cattle_track/responsive_layout.dart';
import 'package:cattle_track/screens/desktop/home_desktop.dart';
import 'package:cattle_track/screens/mobile/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CattleProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cattle Track',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const ResponsiveLayout(
            mobileBody: HomePageMobile(), desktopBody: HomePageDesktop()));
  }
}
