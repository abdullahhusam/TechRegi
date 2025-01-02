import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techlab/shared/components/custom_button.dart';
import 'package:techlab/shared/components/custom_text.dart';
import 'package:techlab/utils/routes.dart';

import '../../../shared/auth_service.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
  }

  Future<void> checkToken() async {
    final AuthService _authService = AuthService();

    final bool isLoggedIn = await _authService.hasValidToken();
    if (isLoggedIn) {
      context.go(entryPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 60),
            child: Image.asset(
              'assets/images/logo.png',
              height: 50,
            ),
          ),
          Image.asset(
            fit: BoxFit.fitWidth,
            'assets/images/start_image.png', // Replace with your image
            // height: 300,
          ),
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     Container(
          //       width: 88,
          //       height: 88,
          //       decoration: const BoxDecoration(
          //         color: primaryColor, // Red background
          //         shape: BoxShape.circle,
          //       ),
          //     ),
          //     SvgPicture.asset(
          //       'assets/icons/digital_transformation.svg',
          //       height: 40.0,
          //       width: 40.0,
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
            child: Column(
              children: [
                const CustomText(
                  text: 'Impactful Innovation,\nRapidly Deployed',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 2.0,
                ),
                const CustomText(
                  marginTop: 30,
                  text: 'Build your Tailored Solutions for your Industry.',
                ),
                CustomButton(
                  marginTop: 40,
                  text: "Start",
                  onPressed: () {
                    context.push(introPath);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
