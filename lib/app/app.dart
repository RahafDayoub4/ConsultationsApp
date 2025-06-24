import 'package:flutter/material.dart';
import 'package:newtest/presentation/resources/routes_manger.dart';
import 'package:newtest/presentation/resources/theme_manger.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key}); //defult constructor

  //named constructor
  MyApp._internal();

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() {
    return _instance; // factory
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRout,
      initialRoute: Routes.logingRoute,
      theme: getAppLicationTheme(),
    );
  }
}
