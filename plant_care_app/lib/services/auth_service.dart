import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxController {
  var userIsAuthenticated = false.obs;
  final token = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  static AuthService get to => Get.find<AuthService>();

  SharedPreferences prefs;

  loadToken() async {
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    userIsAuthenticated.value = token != '' ? true : false;
    setToken(token);
  }

  Future setToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    token = token;
  }

  register(String nome, String email, String senha) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.14:8000/api/auth/register'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "nome": nome,
            "email": email,
            "senha": senha,
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        token.value = data['token'];
        userIsAuthenticated.value = true;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  login(String email, String senha) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.14:8000/api/auth/login'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "senha": senha,
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        token.value = data['token'];
        userIsAuthenticated.value = true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  forgot(String email) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.1.14:8000/api/auth/forgot'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  logout() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.1.14:8000/api/auth/logout'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setToken('');
        userIsAuthenticated.value = false;
      }
    } catch (e) {
      print(e.message);
    }
  }
}
