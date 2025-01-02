import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techlab/shared/auth_view_model.dart';
import 'package:techlab/features/account/view_models/profile_view_model.dart';
import 'package:techlab/features/register/repo/register_services.dart';
import 'package:techlab/features/register/view_models/register_view_model.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Techlab',
        theme: ThemeData(
          textSelectionTheme:
              const TextSelectionThemeData(selectionHandleColor: primaryColor),
          fontFamily: 'Poppins',

          scaffoldBackgroundColor: screenBackgroundColor,
          // useMaterial3: true,
        ),
        routerConfig: createRouter(),
        // home: ContactsScreen()
      ),
    );
  }
}
