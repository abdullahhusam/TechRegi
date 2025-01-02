import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:techlab/shared/colors/colors.dart';
import 'package:techlab/shared/components/custom_button.dart';
import 'package:techlab/shared/components/custom_text.dart';

import '../../../shared/auth_view_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/validation.dart';
import '../components/edit_text_field.dart';
import '../view_models/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  var first = '';
  var last = '';
  var email = '';
  IsValid _validFirstName = IsValid.none;
  IsValid _validLastName = IsValid.none;
  IsValid _validEmail = IsValid.none;
  bool _isLoaded = false;
  bool _editMode = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (!_isLoaded) {
      _isLoaded = true;
      first = viewModel.firstName!;
      last = viewModel.lastName!;
      email = viewModel.email!;
      _email.text = viewModel.email!;
      _firstName.text = viewModel.firstName!;
      _lastName.text = viewModel.lastName!;
      _password.text = "************";
    }

    return viewModel.isLoading
        ? const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: whiteColor,
              title: const Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       GoRouter.of(context).pop();
                  //     },
                  //     icon: const Icon(
                  //       Icons.arrow_back,
                  //       color: textColor,
                  //       size: 22,
                  //     )),
                  CustomText(
                    marginLeft: 5,
                    text: "Profile",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 126,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 0,
                              color: Color(0x2246007F),
                              blurRadius: 11,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: CustomText(
                            text: "Personal Info",
                            fontSize: 13,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      EditTextField(
                        marginTop: 30,
                        onChanged: (value) {
                          setState(() {
                            if (_validFirstName != IsValid.none) {
                              if (validateEmail(value)) {
                                _validFirstName = IsValid.valid;
                              } else {
                                _validFirstName = IsValid.notValid;
                              }
                            }
                          });
                        },
                        labelText: 'First Name',
                        controller: _firstName,
                        type: Type.name,
                        isValid: _validFirstName,
                        enabled: _editMode,
                      ),
                      EditTextField(
                        onChanged: (value) {
                          setState(() {
                            if (_validLastName != IsValid.none) {
                              if (validateEmail(value)) {
                                _validLastName = IsValid.valid;
                              } else {
                                _validLastName = IsValid.notValid;
                              }
                            }
                          });
                        },
                        labelText: 'Last Name',
                        controller: _lastName,
                        type: Type.name,
                        isValid: _validLastName,
                        enabled: _editMode,
                      ),
                      EditTextField(
                        onChanged: (value) {
                          setState(() {
                            if (_validEmail != IsValid.none) {
                              if (validateEmail(value)) {
                                _validEmail = IsValid.valid;
                              } else {
                                _validEmail = IsValid.notValid;
                              }
                            }
                          });
                        },
                        labelText: 'Email',
                        controller: _email,
                        type: Type.email,
                        isValid: _validEmail,
                        enabled: _editMode,
                      ),
                      EditTextField(
                        onChanged: (value) {},
                        labelText: 'Password',
                        controller: _password,
                        type: Type.name,
                        isValid: IsValid.none,
                        enabled: false,
                      ),
                    ],
                  ),
                  if (_editMode == false) ...[
                    CustomButton(
                      text: "Edit",
                      onPressed: () {
                        setState(() {
                          _editMode = true;
                        });
                      },
                    )
                  ],
                  if (_editMode == true) ...[
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            fontColor: primaryColor,
                            borderColor: primaryColor,
                            backgroundColor: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            text: "Cancel",
                            onPressed: () {
                              setState(() {
                                _editMode = false;
                                _lastName.text = last;
                                _firstName.text = first;
                                _email.text = email;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomButton(
                            text: "Save",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            onPressed: () async {
                              bool success = await viewModel.updateContact(
                                authViewModel.token ?? '',
                                _firstName.text,
                                _lastName.text,
                                _email.text,
                              );
                              if (success) {
                                setState(() {
                                  _editMode = false;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Failed to Update')),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    )
                  ]
                ],
              ),
            ),
          );
  }
}
