import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth_service.dart';
import 'auth/login_screen.dart';
import 'admin/admin_dashboard.dart';
import 'public/home_screen.dart';
import 'common/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (_, auth, __) {
        if (auth.isLoading) return const SplashScreen();
        if (!auth.isAuthenticated) return const LoginScreen();
        return auth.isAdmin ? const AdminDashboard() : const HomeScreen();
      },
    );
  }
}
