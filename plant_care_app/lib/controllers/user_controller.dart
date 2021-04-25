import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_plantas/services/user_service.dart';

class UserController extends GetxController {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirm = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getUser();
  }

  getUser() async {
    isLoading.value = true;

    var user = await UserService.to.getUser();

    nome.text = user['name'];
    email.text = user['email'];

    isLoading.value = false;
  }

  editUser() async {
    isLoading.value = true;
    var result = await UserService.to.editUser(nome.text, email.text, senha.text);
    isLoading.value = false;
    return result;
  }
}
