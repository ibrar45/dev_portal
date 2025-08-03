import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_office/app.dart';
import 'package:portal_office/application/auth/auth_bloc.dart';
import 'package:portal_office/infrastructure/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(BlocProvider(
    create: (context) => AuthBloc(authService: AuthService()),
    child: const MyApp(),
  ));
}
