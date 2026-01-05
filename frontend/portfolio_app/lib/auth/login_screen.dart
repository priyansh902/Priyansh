import 'package:flutter/material.dart';
import 'package:portfolio_app/auth/register_screen.dart';
import 'package:portfolio_app/public/home_screen.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _S();
}

class _S extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  await c.read<AuthService>().login(
                        email.text,
                        password.text,
                      );
                },
                child: const Text('Login'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    c,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Create new account'),
              ),

              //  FORCE NEW HOME
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    c,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
                child: const Text('Continue as Visitor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
