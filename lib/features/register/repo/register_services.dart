import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class RegisterServices {
  final String baseUrl = 'https://ititasks.crm11.dynamics.com/api/data/v9.2';

  Future<List<dynamic>?> fetchContacts(String accessToken) async {
    final url = Uri.parse('$baseUrl/contacts');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'OData-MaxVersion': '4.0',
        'OData-Version': '4.0',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['value'];
    } else {
      print(
          'Error fetching contacts: ${response.statusCode} ${response.reasonPhrase}');
      return null;
    }
  }

  Future<void> createContact(String token, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('https://ititasks.crm11.dynamics.com/api/data/v9.0/contacts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation'
        },
        body: jsonEncode(data),
      );

      print(response.statusCode);

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final contactId = responseData['contactid'];

        // Store contact ID in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('contactId', contactId);

        print("Registered Successfully. Contact ID: $contactId");
      } else {
        throw Exception('Failed to create contact: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating contact: $e');
      rethrow; // Re-throw the exception if you want it to propagate further.
    }
  }
}
