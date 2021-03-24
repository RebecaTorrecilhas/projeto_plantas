import 'package:flutter/material.dart';
import 'package:projeto_plantas/pages/addPlanta.dart';
import 'package:projeto_plantas/pages/plantasList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/038-botanic.png',
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlantasList(),
                          ));
                    },
                    child: Text(
                      'Minhas plantas',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 50),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddPlanta(),
                          ));
                    },
                    child: Text(
                      'Adicionar planta',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(350, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}