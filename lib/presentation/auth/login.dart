import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_office/application/auth/auth_bloc.dart';
import 'package:portal_office/application/auth/auth_event/auth_event.dart';
import 'package:portal_office/application/auth/auth_state/auth_state.dart';
import 'package:portal_office/presentation/auth/signup.dart';
import 'package:portal_office/presentation/dashboard/dashboard.dart';

import '../../config/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Logo from URL
                  Image.asset(
                    BrandingConfig.logoAsset,
                    height: 100,
                  ),
                  const SizedBox(height: 50),

                  // Brand Name

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val != null && val.contains('@')
                        ? null
                        : 'Invalid email',
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (val) => val != null && val.length >= 6
                        ? null
                        : 'Min 6 characters',
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 16),
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  context
                                      .read<AuthBloc>()
                                      .add(LoginRequested(email, password));
                                }
                              },
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Login"),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Signup Redirect
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
