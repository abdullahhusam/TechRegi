import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:techlab/shared/auth_service.dart';
import 'package:techlab/features/account/views/account_screen.dart';
import 'package:techlab/features/register/repo/register_services.dart';
import 'package:techlab/utils/routes.dart';

import '../../../shared/auth_view_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/validation.dart' as val;
import '../user_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterServices _contactsService = RegisterServices();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  IsValid _validFirstName = IsValid.none;
  IsValid get validFirstName => _validFirstName;

  IsValid _validLastName = IsValid.none;
  IsValid get validLastName => _validLastName;

  IsValid _validEmail = IsValid.none;
  IsValid get validEmail => _validEmail;

  IsValid _validPassword = IsValid.none;
  IsValid get validPassword => _validPassword;

  void validateFirstName(String value) {
    _validFirstName =
        val.validateName(value) ? IsValid.valid : IsValid.notValid;
    print(value);
    print(_validFirstName);
    notifyListeners();
  }

  void validateLastName(String value) {
    _validLastName = val.validateName(value) ? IsValid.valid : IsValid.notValid;
    notifyListeners();
  }

  void validateEmail(String value) {
    _validEmail = val.validateEmail(value) ? IsValid.valid : IsValid.notValid;
    notifyListeners();
  }

  void validatePassword(String value) {
    _validPassword = value.length >= 6 ? IsValid.valid : IsValid.notValid;
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> registerContact(
      BuildContext context, UserModel registerModel) async {
    _isLoading = true;
    notifyListeners();
    validateFirstName(registerModel.firstName);
    validateLastName(registerModel.lastName);
    validateEmail(registerModel.email);
    validatePassword(registerModel.password);
    if (validFirstName != IsValid.notValid &&
        validLastName != IsValid.notValid &&
        validEmail != IsValid.notValid &&
        validPassword != IsValid.notValid) {
      try {
        var token =
            Provider.of<AuthViewModel>(context, listen: false).token ?? '';
        if (token.isEmpty) {
          final accessToken = await _authService.fetchToken();
          Provider.of<AuthViewModel>(context, listen: false)
              .authenticate(accessToken!);
          print("I got the token$accessToken");
          token =
              Provider.of<AuthViewModel>(context, listen: false).token ?? '';
        }
        if (token.isEmpty) throw Exception('No valid access token found.');

        final hashedPassword = _hashPassword(registerModel.password);
        final data = registerModel.toJson();
        data['adx_identity_passwordhash'] = hashedPassword;

        await _contactsService.createContact(token, data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contact registered successfully!')),
        );
        context.go(entryPath);

        // Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register contact: $e')),
        );
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      _isLoading = false;
      notifyListeners();
      print("something is not valid");
    }
  }
}
