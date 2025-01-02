// app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techlab/features/account/views/profile_screen.dart';
import 'package:techlab/features/intro/views/intro_screen.dart';
import 'package:techlab/features/intro/views/start_screen.dart';
import 'package:techlab/features/register/views/register_screen.dart';

import '../shared/auth_service.dart';
import '../shared/entry_screen.dart';

// Define route paths
const String startPath = '/start';
const String introPath = '/intro';
const String registerPath = '/register';
const String profilePath = '/profile';

const String entryPath = '/entry';
final AuthService _authService = AuthService();

// Function to create a GoRouter instance based on the login status
GoRouter createRouter() {
  return GoRouter(
    initialLocation: startPath,
    routes: [
      GoRoute(
        path: startPath,
        builder: (context, state) => StartScreen(),
      ),
      GoRoute(
        path: introPath,
        builder: (context, state) => IntroScreen(),
      ),
      GoRoute(
        path: registerPath,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: entryPath,
        builder: (context, state) => EntryScreen(),
      ),
      GoRoute(
        path: profilePath,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
