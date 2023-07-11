
import 'package:flutter/material.dart';
import 'package:hommie/core/fire_base/login_with_google_nav.dart';
import 'package:hommie/presentation/bottom_bar_navigator/bottom_bar_navigator.dart';

import '../presentation/sign_in_screen/sign_in_screen.dart';

class AppRoutes {
  static const String signInScreen = '/sign_in_screen';
  static const String homeScreen = '/home_screen';
  static const String googleNav = '/login_with_google_nav';
  static Map<String, WidgetBuilder> routes = {
    signInScreen: (context) => const SignInScreen(),
    homeScreen: (context) =>
        BottomBarNavigator(selectedIndex: 0, isBottomNav: true),
    googleNav: (context) => const LoginWithGoogleNav(),
  };
}
