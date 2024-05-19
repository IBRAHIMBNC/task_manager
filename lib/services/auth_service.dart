import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/enums/auth_response.dart';
import 'package:task_manager/app/models/app_user.dart';
import 'package:task_manager/services/local_storage_service.dart';

class AuthService {
  AppUser? appUser;
  bool isUserLoggedIn = false;
  final _localStorageService = locator<LocalStorageService>();
  static const String _loginEndpoint = 'https://dummyjson.com/auth/login';
  static const String _currentUserEndpoint = 'https://dummyjson.com/auth/me';

  // This method is called when the app starts up to check if the user is logged in
  Future<void> init() async {
    final token = _localStorageService.authToken;
    if (token != null) {
      debugPrint('Expiry Time: ${_localStorageService.expiryTime}');
      if (_localStorageService.expiryTime!.isBefore(DateTime.now())) {
        debugPrint('Token is expired');
        _localStorageService.deleteToken();
        appUser = null;
        return;
      }
      debugPrint('Token is not null');
      await getCurrentUser(token);
    } else {
      debugPrint('Token is null');
    }
  }

  // This method is called when the user tries to login
  Future<AuthResponse> login(String username, String password) async {
    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(_loginEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final token = data['token'];
      final expiryTime = data['expiresInMins'] ?? 60;
      appUser = AppUser.fromMap(data);
      _localStorageService.saveSession(token, expiryTime);

      return AuthResponse.success;
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['message'] == 'Invalid credentials') {
        return AuthResponse.invalidCredentials;
      }
      return AuthResponse.unKnown;
    }
  }

  // This method is called when the user tries to login
  Future<void> getCurrentUser(String authToken) async {
    final response = await http.get(
      Uri.parse(_currentUserEndpoint),
      headers: {'Authorization': authToken},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      appUser = AppUser.fromMap(data);
      appUser = appUser!.copyWith(token: authToken);
      isUserLoggedIn = true;
    } else {
      appUser = null;
      isUserLoggedIn = false;
    }
  }

  logout() {
    _localStorageService.deleteToken();
    appUser = null;
  }
}
