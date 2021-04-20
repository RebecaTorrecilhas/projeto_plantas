import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  register(String nome, String email, String password) async {
    try {
      // to do
    } catch (e) {
      // validar erro
    }
  }

  login(String email, String password) async {
    try {
      // to do
    } catch (e) {
      // validar erro
    }
  }

  forgot(String email) async {
    try {
      // to do
    } catch (e) {
      // validar erro
    }
  }

  logout() async {
    try {
      // aqui faz logout no backend
      setToken('');
      userIsAuthenticated.value = false;
    } catch (e) {
      // validar erro
    }
  }
}
