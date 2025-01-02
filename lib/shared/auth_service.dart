import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techlab/utils/secrets.dart';

class AuthService {
  final String _clientId = clientId;
  final String _clientSecret = secret;
  final String _tenantId = tenantId; // Replace with your tenant ID if needed
  final String _resourceUrl = 'https://ititasks.crm11.dynamics.com/.default';

  Future<String?> fetchToken() async {
    final url = Uri.parse(
      'https://login.microsoftonline.com/$_tenantId/oauth2/v2.0/token',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': _clientId,
        'client_secret': _clientSecret,
        'scope': _resourceUrl,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['access_token'];
    } else {
      print('Failed to fetch token: ${response.body}');
      return null;
    }
  }

  Future<bool> hasValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('contactId');
    return token != null; // Returns true if the token exists
  }
}
