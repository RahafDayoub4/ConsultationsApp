import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newtest/presentation/resources/color_manger.dart';
import 'package:newtest/presentation/resources/routes_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDely() {
    _timer = Timer(Duration(seconds: 3), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
  }

  @override
  void initState() {
    
    super.initState();
    _startDely();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: Center(child: Text('data')),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
