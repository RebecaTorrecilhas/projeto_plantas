import 'package:flutter/material.dart';
import 'package:projeto_plantas/models/plant.dart';

class PlantasView extends StatefulWidget {
  Plant planta;
  PlantasView({Key key, this.planta}) : super(key: key);

  @override
  _PlantasViewState createState() => _PlantasViewState();
}

class _PlantasViewState extends State<PlantasView> {
  deletePlanta(BuildContext contextClass) {
    return showDialog(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Deseja realmente apagar?'),
            actions: <Widget>[
              TextButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(contextClass).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.planta.especie,
        ),
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: () => deletePlanta(context)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                widget.planta.icon,
                height: 180,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('Observações',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                widget.planta.obs,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('Tempo de Irrigação',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                widget.planta.irrigacao,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
