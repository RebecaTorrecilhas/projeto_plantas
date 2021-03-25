import 'package:flutter/material.dart';
import '../controllers/plants_controller.dart';

class PlantasList extends StatefulWidget {
  @override
  _PlantasListState createState() => _PlantasListState();
}

class _PlantasListState extends State<PlantasList> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = PlantsController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas plantas'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.plantas.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(controller.plantas[index].icon, height: 120),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.plantas[index].especie,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Tempo de irrigação',
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
          }),
    );
  }
}
