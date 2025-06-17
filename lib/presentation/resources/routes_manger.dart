import 'package:flutter/material.dart';
import 'package:newtest/presentation/forgot_password/forgot_password_view.dart';
import 'package:newtest/presentation/login/view/login_view.dart';
import 'package:newtest/presentation/onboarding/view/onboarding_view.dart';
import 'package:newtest/presentation/register/register_view.dart';
import 'package:newtest/presentation/resources/strings_manger.dart';
import 'package:newtest/presentation/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String logingRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRout(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case Routes.logingRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      default:
        return unDefindedRoute();
    }
  }

  static Route<dynamic> unDefindedRoute() {
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(title: Text(AppStrings.routeNotFound),),
      body: Center(child: Text("No Route Found")),
    ));
  }
}
