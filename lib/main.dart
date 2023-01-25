import 'package:flutter/material.dart';
import 'package:qkard_task/theme/app_theme.dart';
import 'package:qkard_task/utils/notification_service.dart';
import 'package:qkard_task/utils/route_generator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: RouteGenerator.initialRoute,
    );
  }
}
