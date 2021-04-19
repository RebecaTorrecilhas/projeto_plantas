import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'pages/login.dart';

void main() {
  Get.lazyPut<ThemeController>(() => ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();

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
      home: Login(),
    );
  }
}
