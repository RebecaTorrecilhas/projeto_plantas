import 'package:flutter/material.dart';

class PlantasList extends StatefulWidget {
  @override
  _PlantasListState createState() => _PlantasListState();
}

class _PlantasListState extends State<PlantasList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minhas plantas'),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.asset('images/038-botanic.png'),
                    minVerticalPadding: 30,
                    title: Text('Sonu Nigam'),
                    subtitle: Text('Best of Sonu Nigam Song'),
                    onTap: () => {},
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
