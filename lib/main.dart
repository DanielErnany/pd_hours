import 'package:flutter/material.dart';
import 'package:pd_hours/pages/home_page.dart';
import 'package:pd_hours/providers/employees_provider.dart';
import 'package:pd_hours/providers/squads_provider.dart';
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
        ChangeNotifierProvider(create: (ctx) => SquadsProvider()),
        ChangeNotifierProvider(create: (ctx) => EmployeesProvider()),
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
