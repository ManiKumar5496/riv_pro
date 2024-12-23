import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:riv_pro/app_routes/app_routes.dart';
import '../../../app/api/api_constants.dart';
import '../../../main.dart';

class LoginState {
  final String? usernameError;
  final String? passwordError;
  final bool isLoading;
  final bool isLoggedIn;

  LoginState({
    this.usernameError,
    this.passwordError,
    this.isLoading = false,
    this.isLoggedIn = false,
  });
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState()) {
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final box = Hive.box('userBox');
    final isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    state = LoginState(isLoggedIn: isLoggedIn);
  }

  Future<void> login(context, String username, String password) async {
    state = LoginState(isLoading: true);

    if (username.isEmpty && password.isEmpty) {
      state = LoginState(
        usernameError: "Username cannot be empty", // Set username error
        passwordError: "Password cannot be empty", // Set password error
        isLoading: false,
      );
      _showSnackBar(context, 'Username and Password cannot be empty',
          Colors.red, Colors.white);
      return; // Return early to stop further execution
    }

    if (username.isEmpty) {
      state = LoginState(
        usernameError: "Username cannot be empty", // Set username error
        isLoading: false, // Stop loading if validation fails
      );
      _showSnackBar(
          context, 'Username cannot be empty', Colors.red, Colors.white);
      return;
    }

    // Check if the password is empty
    if (password.isEmpty) {
      state = LoginState(
        passwordError: "Password cannot be empty", // Set password error
        isLoading: false, // Stop loading if validation fails
      );
      _showSnackBar(
          context, 'Password cannot be empty', Colors.red, Colors.white);
      return;
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final Map<String, dynamic> body = {
      "username": username,
      "password": password,
      "expiresInMins": 30
    };

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.loginEndPoint),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        state = LoginState(isLoggedIn: true);
        _saveUserData(username);
        _showSnackBar(
            context, 'Logged in successfully', Colors.green, Colors.white);
        Navigator.pushNamed(context, AppRoutes.home);
      } else {
        state = LoginState(
          usernameError: "Please check your username",
          passwordError: "Please check your password",
        );
        _showSnackBar(context, 'Login failed', Colors.red, Colors.white);
        log.d("hello ${state.isLoggedIn}");
      }
    } catch (e) {
      _showSnackBar(context, 'An error occurred: ${e.toString()}', Colors.red,
          Colors.white);
    } finally {
      state = LoginState(isLoading: false); // Reset loading state
    }
  }

  Future<void> logout(context) async {
    final box = Hive.box('userBox');
    await box.put('isLoggedIn', false);
    await box.delete('username');

    state = LoginState(isLoggedIn: false); // Update the state
    _showSnackBar(
        context, 'Logged out successfully', Colors.blue, Colors.white);
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _showSnackBar(BuildContext context, String message,
      Color backgroundColor, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

void _saveUserData(String username) async {
  final box = Hive.box('userBox');
  await box.put('isLoggedIn', true);
  await box.put('username', username);
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
