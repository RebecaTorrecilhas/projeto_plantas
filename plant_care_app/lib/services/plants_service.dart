import 'dart:convert';
import 'package:get/get.dart';
import 'package:projeto_plantas/services/auth_service.dart';
import 'package:http/http.dart' as http;

class PlantsService extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  static PlantsService get to => Get.find<PlantsService>();

  getAll() async {
    try {
      var token = AuthService.to.token;

      var response = await http.get(
        Uri.parse('http://192.168.1.14:8000/api/plant/all'),
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

  add(String especie, String icon, String irrigar, String obs) async {
    try {
      var token = AuthService.to.token;

      var response = await http.post(
        Uri.parse('http://192.168.1.14:8000/api/plant'),
        headers: <String, String>{
          'Accept': 'application/json;',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          <String, String>{
            "especie": especie,
            "icon": icon,
            "irrigar": irrigar,
            "obs": obs,
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
}
