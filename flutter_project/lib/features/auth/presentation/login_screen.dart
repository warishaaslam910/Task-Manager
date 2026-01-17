import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          if (state is AuthLoggedIn) {
            //Navigator.pushReplacementNamed(context, '/');
            context.go('/');

          }
        },
        builder: (_, state) {
          if (state is AuthLoading) return const Center(child: CircularProgressIndicator());
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
                TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(_usernameController.text, _passwordController.text);
                    print("ddcbjdwc,jbd");
                    print(context.read<AuthCubit>().state);

                  },

                    child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
