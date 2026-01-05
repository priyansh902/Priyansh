
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api_service.dart';


class AuthService extends ChangeNotifier {
  final api = ApiService();

  String? _token;
  bool _isAdmin = false;
  final bool _loading = false;

  bool get isAuthenticated => _token != null;
  bool get isAdmin => _isAdmin;
  bool get isLoading => _loading;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    final res = await api.post('/api/auth/login', {
      'email': email,
      'password': password,
    });

    _token = res['token'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);

    await fetchMe();
    notifyListeners();
    return true;
  }

  Future<void> fetchMe() async {
    final me = await api.get('/api/auth/me', token: _token);
    final roles = me['authorities'] ?? [];
    _isAdmin = roles.any((r) => r.toString().contains('ROLE_ADMIN'));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _isAdmin = false;
    notifyListeners();
  }
}
