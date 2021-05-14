import 'dart:convert';
import 'package:get/get.dart';
import 'package:projeto_plantas/constants.dart';
import 'package:projeto_plantas/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var constants = Get.put(Constants());
  static UserService get to => Get.find<UserService>();

  getUser() async {
    try {
      var token = AuthService.to.token;

      var response = await http.get(
        Uri.parse('${constants.url}/user'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  editUser(String nome, String email, String senha) async {
    try {
      var token = AuthService.to.token;

      var response = await http.put(
        Uri.parse('${constants.url}/user'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
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
        if (response.body.isEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }

  destroyUser() async {
    try {
      var token = AuthService.to.token;

      var response = await http.delete(
        Uri.parse('${constants.url}/user'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
    }
  }
}
