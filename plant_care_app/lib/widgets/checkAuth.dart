import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:projeto_plantas/pages/login.dart';
import 'package:projeto_plantas/pages/plantasList.dart';
import 'package:projeto_plantas/services/auth_service.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value
        ? PlantasList()
        : Login());
  }
}