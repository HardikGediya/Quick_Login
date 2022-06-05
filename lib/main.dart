import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/signIn_screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences pref = await SharedPreferences.getInstance();

  bool isLoggedIn = pref.getBool('isLoggedIn') ?? false;
  bool isRegisteredIn = pref.getBool('isRegisteredIn') ?? false;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: (isRegisteredIn == false)
          ? 'sign_up_screen'
          : (isLoggedIn == false)
              ? 'sign_in_screen'
              : 'welcome_screen',
      routes: {
        'sign_in_screen': (context) => const SignInScreen(),
        'sign_up_screen': (context) => const SignUpScreen(),
        'welcome_screen': (context) => const WelcomeScreen(),
      },
    ),
  );
}
