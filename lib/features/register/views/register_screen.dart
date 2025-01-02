import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techlab/features/register/user_model.dart';
import 'package:techlab/utils/constants.dart';
import '../../../shared/components/custom_button.dart';
import '../../../shared/components/custom_text_field.dart';
import '../view_models/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  'assets/images/start_image.png',
                ),
              ],
            ),
            Stack(
              children: [
                Image.asset(
                  fit: BoxFit.fill,
                  'assets/images/register_image.png',
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 7, 24, 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              type: Type.name,
                              hintText: 'First Name',
                              controller: _firstName,
                              onChanged:
                                  viewModel.validFirstName != IsValid.none
                                      ? viewModel.validateFirstName
                                      : null,
                              isValid: viewModel.validFirstName,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextField(
                              type: Type.name,
                              hintText: 'Last Name',
                              controller: _lastName,
                              onChanged: viewModel.validLastName != IsValid.none
                                  ? viewModel.validateLastName
                                  : null,
                              isValid: viewModel.validLastName,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        type: Type.email,
                        hintText: 'Email',
                        controller: _email,
                        onChanged: viewModel.validEmail != IsValid.none
                            ? viewModel.validateEmail
                            : null,
                        isValid: viewModel.validEmail,
                      ),
                      CustomTextField(
                        type: Type.password,
                        hintText: 'Password',
                        controller: _password,
                        onChanged: viewModel.validPassword != IsValid.none
                            ? viewModel.validatePassword
                            : null,
                        isValid: viewModel.validPassword,
                      ),
                      CustomButton(
                        marginTop: 35,
                        text: viewModel.isLoading ? "Loading..." : "Register",
                        onPressed: viewModel.isLoading
                            ? null
                            : () {
                                final model = UserModel(
                                  firstName: _firstName.text,
                                  lastName: _lastName.text,
                                  email: _email.text,
                                  password: _password.text,
                                );
                                viewModel.registerContact(context, model);
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
