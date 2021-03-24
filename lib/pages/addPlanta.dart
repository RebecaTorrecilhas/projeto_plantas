import 'package:flutter/material.dart';

class AddPlanta extends StatefulWidget {
  @override
  _AddPlantaState createState() => _AddPlantaState();
}

class _AddPlantaState extends State<AddPlanta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Planta'),
      ),
      body: Form(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.eco),
                    border: OutlineInputBorder(),
                    labelText: 'Espécie da Planta'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe a espécie da planta.';
                  }
                  return null;
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            child: TextFormField(
                minLines: 2,
                maxLines: 6,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.article),
                    border: OutlineInputBorder(),
                    labelText: 'Observações'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe as observações';
                  }
                  return null;
                }),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () => {},
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 50),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
