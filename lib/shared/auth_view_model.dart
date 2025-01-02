import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

class AuthViewModel with ChangeNotifier {
  String? _token;

  String? get token => _token;
  final AuthService _authService = AuthService();

  bool get isAuthenticated => _token != null;

  /// Load the token from local storage during app initialization
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('accessToken');
    notifyListeners();
  }

  Future<void> getToken() async {
    final accessToken = await _authService.fetchToken();

    _token = accessToken ?? '';
    authenticate(_token!);

    notifyListeners();
  }

  /// Save the token and notify listeners
  Future<void> authenticate(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    notifyListeners();
  }

  /// Clear the token and notify listeners
  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    notifyListeners();
  }
}
