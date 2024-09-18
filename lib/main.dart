import 'package:flutter/material.dart';
import 'package:pd_hours/pages/home_page.dart';
import 'package:pd_hours/providers/squad_provider.dart';
import 'package:pd_hours/utils/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SquadProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PD Hours',
        theme: appTheme,
        home: const HomePage(),
      ),
    );
  }
}
