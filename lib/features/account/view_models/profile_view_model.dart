import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:techlab/features/account/repo/profile_services.dart';
import 'package:techlab/features/register/repo/register_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final RegisterServices _registerServices = RegisterServices();
  final ProfileServices _profileServices = ProfileServices();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _firstName;
  String? _lastName;
  String? _email;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;

  Future<void> clearId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('contactId'); // Remove the token
  }

  Future<void> fetchContact() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('accessToken')!;
    try {
      final prefs = await SharedPreferences.getInstance();
      final contactId = prefs.getString('contactId');

      if (contactId == null) {
        throw Exception("No contact ID found");
      }

      final response = await _registerServices.fetchContacts(token);
      final contact = response?.firstWhere(
        (c) => c['contactid'] == contactId,
        orElse: () => null,
      );

      if (contact != null) {
        print("Got Contact");
        print(contact['firstname']);
        _firstName = contact['firstname'];
        _lastName = contact['lastname'];
        _email = contact['emailaddress1'];
      } else {
        throw Exception("Contact not found");
      }
    } catch (e) {
      print("Error fetching contact: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateContact(
      String token, String firstName, String lastName, String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final contactId = prefs.getString('contactId');
      print(contactId);
      if (contactId == null) {
        throw Exception("No contact ID found");
      }

      final data = {
        'firstname': firstName,
        'lastname': lastName,
        'emailaddress1': email,
      };
      bool success =
          await _profileServices.updateContact(token, contactId, data);

      _firstName = firstName;
      _lastName = lastName;
      _email = email;
      fetchContact();
      return success;
    } catch (e) {
      print("Error updating contact: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
