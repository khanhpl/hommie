import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hommie/core/app_export.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        primarySwatch: MaterialColor(
          0x00e2994a,
          <int, Color>{
            50: const Color(0x00e2994a).withOpacity(0.05),
            100: const Color(0x00e2994a).withOpacity(0.1),
            200: const Color(0x00e2994a).withOpacity(0.2),
            300: const Color(0x00e2994a).withOpacity(0.3),
            400: const Color(0x00e2994a).withOpacity(0.4),
            500: const Color(0x00e2994a).withOpacity(0.5),
            600: const Color(0x00e2994a).withOpacity(0.6),
            700: const Color(0x00e2994a).withOpacity(0.7),
            800: const Color(0x00e2994a).withOpacity(0.8),
            900: const Color(0x00e2994a).withOpacity(0.9),
          },
        ),
      ),
      title: 'login',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: AppRoutes.routes,
    );
  }
}
