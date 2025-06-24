import 'package:flutter/material.dart';
import 'package:newtest/app/app.dart';
import 'package:newtest/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
