import 'dart:collection';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:projeto_plantas/models/plant.dart';
import '../services/plants_service.dart';
import '../services/auth_service.dart';

class PlantsController extends GetxController {
  final especie = TextEditingController();
  final obs = TextEditingController();
  final irrigar = TextEditingController();
  final icon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;

  RxList<dynamic> plantas = RxList<dynamic>();

  onInit() {
    super.onInit();
    getAll();
    ever(AuthService.to.token , (token) {
      getAll();
      formKey.currentState.reset();
    });
  }

  getAll() async {
    isLoading.value = true;

    List<dynamic> plants = await PlantsService.to.getAll();

    plantas.removeWhere((plant) => true);
    plantas.addAll(plants);

    isLoading.value = false;
  }

  add() async {
    isLoading.value = true;

    var result = await PlantsService.to.add(especie.text, icon.text, irrigar.text, obs.text);
    
    getAll();
    formKey.currentState.reset();

    isLoading.value = false;
    
    return result;
  }
}
