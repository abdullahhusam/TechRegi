import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:techlab/features/account/components/tile_component.dart';
import 'package:techlab/features/intro/views/start_screen.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/shared/components/custom_text.dart';
import 'package:techlab/utils/routes.dart';

import '../view_models/profile_view_model.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return viewModel.isLoading
        ? const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 16, top: 60, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/account_logo.png',
                        height: 114,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.clearId();
                          context.go(registerPath);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/logout.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    marginTop: 35,
                    marginBottom: 8,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                    text: "Welcome, \n ${viewModel.firstName}",
                  ),
                  TileComponent(
                    onTap: () {
                      context.push(profilePath);
                    },
                    text: 'Profile',
                  ),
                  TileComponent(
                    onTap: () {},
                    text: 'Notifications',
                  ),
                  TileComponent(
                    onTap: () {},
                    text: 'Change Password',
                  ),
                  TileComponent(
                    onTap: () {},
                    text: 'Manage Account',
                  ),
                ],
              ),
            ),
          );
  }
}
