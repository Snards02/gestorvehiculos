import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  static const _tokenKey = 'auth_token';

  @observable
  String? token;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
  }

  @action
  Future<bool> login(String email, String password) async {
    isLoading = true;
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, token!);
        return true;
      }
      return false;
    } catch (e) {
      print('Error de login: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    token = null;
  }
}
