import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_plantas/services/auth_service.dart';
import 'addPlanta.dart';
import 'plantasView.dart';
import '../controllers/theme_controller.dart';
import '../controllers/plants_controller.dart';
import 'editUser.dart';

class PlantasList extends StatefulWidget {
  @override
  _PlantasListState createState() => _PlantasListState();
}

class _PlantasListState extends State<PlantasList> {
  var themeController = ThemeController.to;
  var controller = Get.put(PlantsController());
  final isLoading = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas plantas'), actions: [
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Editar conta'),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUser(),
                          ),
                        ),
                      }),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Obx(() => themeController.isDark.value
                    ? Icon(Icons.brightness_5)
                    : Icon(Icons.brightness_2_outlined)),
                title: Obx(() => themeController.isDark.value
                    ? Text('Light')
                    : Text('Dark')),
                onTap: () => themeController.changeTheme(),
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () async {
                  isLoading.value = true;
                  Navigator.pop(context);
                  await AuthService.to.logout();
                  isLoading.value = false;
                },
              ),
            ),
          ],
        ),
      ]),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.plantas.length == 0
                ? Center(
                    child: Text(
                    'Não há plantinhas cadastradas :( ',
                    style: TextStyle(fontSize: 20),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.plantas.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlantasView(
                                key: Key(controller.plantas[index]['especie']),
                                planta: controller.plantas[index],
                              ),
                            ),
                          )
                        },
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Image.asset(controller.plantas[index]['icon'],
                                    height: 120),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.plantas[index]['especie'],
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Irrigar: ' +
                                            controller.plantas[index]
                                                ['irrigar'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPlanta(),
                ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
