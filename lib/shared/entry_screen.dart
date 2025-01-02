import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:techlab/shared/auth_view_model.dart';
import 'package:techlab/features/account/view_models/profile_view_model.dart';
import 'package:techlab/features/account/views/account_screen.dart';
import 'package:techlab/features/home/views/home_screen.dart';

import 'colors/colors.dart';

class EntryScreen extends StatefulWidget {
  final int index;
  const EntryScreen({super.key, this.index = 0});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late int _selectedIndex;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthViewModel>(context, listen: false).getToken();
      Provider.of<ProfileViewModel>(context, listen: false).fetchContact();
    });
    super.initState();
    _selectedIndex = widget.index;
  }

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [AccountScreen(), HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disables the back button
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          elevation: 10,
          onTap: navigateBottomBar,
          unselectedItemColor: disabledPrimaryColor,
          selectedItemColor: primaryColor,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 10),
                  child: Icon(
                    Icons.person,
                    color: _selectedIndex == 0
                        ? primaryColor
                        : disabledPrimaryColor,
                  )),
              label: 'Account',
            ),
            BottomNavigationBarItem(
                icon: Padding(
                    padding: const EdgeInsets.only(bottom: 6, top: 10),
                    child: Icon(
                      Icons.home,
                      color: _selectedIndex == 1
                          ? primaryColor
                          : disabledPrimaryColor,
                    )),
                label: 'Home'),
          ],
        ),
      ),
    );
  }
}
