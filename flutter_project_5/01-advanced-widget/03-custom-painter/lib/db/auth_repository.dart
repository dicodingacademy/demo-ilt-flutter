import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AuthRepository {
  final String stateKey = "state";
  final String userKey = "user";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    return preferences.setBool(stateKey, false);
  }

  Future<bool> saveUser(User user) async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    final userJson = jsonEncode(user.toJson());
    return preferences.setString(userKey, userJson);
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    return preferences.setString(userKey, "");
  }

  Future<User?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    final json = preferences.getString(userKey) ?? "";
    User? user;
    final userJson = jsonDecode(json);
    try {
      user = User.fromJson(userJson);
    } catch (e) {
      user = null;
    }
    return user;
  }
}
