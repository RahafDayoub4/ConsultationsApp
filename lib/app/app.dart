import 'package:flutter/material.dart';

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
    return  Container();
  }
}
