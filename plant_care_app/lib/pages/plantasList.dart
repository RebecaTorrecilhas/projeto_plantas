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
  var controller = ThemeController.to;
  var repositorio = PlantsController();
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
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditUser(),
                      ))),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Obx(() => controller.isDark.value
                    ? Icon(Icons.brightness_5)
                    : Icon(Icons.brightness_2_outlined)),
                title: Obx(() =>
                    controller.isDark.value ? Text('Light') : Text('Dark')),
                onTap: () => controller.changeTheme(),
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
        () => isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: repositorio.plantas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlantasView(
                            key: Key(repositorio.plantas[index].especie),
                            planta: repositorio.plantas[index],
                          ),
                        ),
                      )
                    },
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Image.asset(repositorio.plantas[index].icon,
                                height: 120),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    repositorio.plantas[index].especie,
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Irrigar: ' +
                                        repositorio.plantas[index].irrigacao,
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
