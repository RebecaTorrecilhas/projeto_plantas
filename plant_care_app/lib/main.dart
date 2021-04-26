import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_plantas/services/user_service.dart';
import 'package:projeto_plantas/widgets/checkAuth.dart';
import 'controllers/theme_controller.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/plants_service.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
  Get.lazyPut<UserService>(() => UserService());
  Get.lazyPut<PlantsService>(() => PlantsService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();
    AuthService.to.loadToken();

    return GetMaterialApp(
      title: 'Plant Care',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Gotham',
        backgroundColor: Colors.green[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.grey,
        accentColor: Colors.white,
        accentIconTheme: IconThemeData(color: Colors.black),
        primarySwatch: Colors.grey,
        dividerColor: Colors.black45,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
      ),
      themeMode: ThemeMode.system,
      home: CheckAuth(),
    );
  }
}
