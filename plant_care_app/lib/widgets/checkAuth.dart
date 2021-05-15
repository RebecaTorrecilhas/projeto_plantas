import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../pages/plantasList.dart';
import '../pages/login.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value
        ? PlantasList()
        : Login());
  }
}