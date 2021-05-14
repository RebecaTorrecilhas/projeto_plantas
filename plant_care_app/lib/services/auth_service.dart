import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_plantas/constants.dart';

class AuthService extends GetxController {
  var constants = Get.put(Constants());
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

  Future setToken(String tokenNew) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', tokenNew);
    token.value = tokenNew;
  }

  register(String nome, String email, String senha) async {
    try {
      var response = await http.post(
        Uri.parse('${constants.url}/auth/register'),
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

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setToken(data['token']);
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
        Uri.parse('${constants.url}/auth/login'),
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

        setToken(data['token']);
        userIsAuthenticated.value = true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  forgot(String email) async {
    try {
      var response = await http.post(
        Uri.parse('${constants.url}/auth/forgot'),
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

  resetToken() {
    setToken('');
    userIsAuthenticated.value = false;
  }

  logout() async {
    try {
      var response = await http.get(
        Uri.parse('${constants.url}/auth/logout'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        resetToken();
      }
    } catch (e) {
      print(e.message);
    }
  }
}
