import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_office/application/auth/auth_bloc.dart';
import 'package:portal_office/application/auth/auth_event/auth_event.dart';
import 'package:portal_office/application/auth/auth_state/auth_state.dart';
import 'package:portal_office/config/config.dart';

import '../dashboard/dashboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          print(state.error);
        } else if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SignUp Successfull")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()));
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return Column(
                    children: [
                      Image.asset(
                        BrandingConfig.logoAsset,
                        height: 80,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        BrandingConfig.appName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val != null && val.contains('@')
                            ? null
                            : 'Please enter a valid email',
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (val) => val != null && val.length >= 6
                            ? null
                            : 'Password must be at least 6 characters',
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (val) => val != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Will implement BLoC logic here later
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            context
                                .read<AuthBloc>()
                                .add(SignupRequested(email, password));
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Back to login
                        },
                        child: const Text("Already have an account? Login"),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
