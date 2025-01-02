import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices {
  final String baseUrl = 'https://ititasks.crm11.dynamics.com/api/data/v9.2';

  Future<bool> updateContact(
      String token, String contactId, Map<String, dynamic> data) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/contacts($contactId)'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 204) {
        print("Contact updated successfully");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error updating contact: $e");
      rethrow;
    }
  }
}
