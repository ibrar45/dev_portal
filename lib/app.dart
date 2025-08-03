import 'package:flutter/material.dart';
import 'package:portal_office/config/config.dart';
import 'package:portal_office/config/theme.dart';
import 'package:portal_office/presentation/auth/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BrandingConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
