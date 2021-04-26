import 'package:flutter/material.dart';
import 'package:projeto_plantas/constants.dart';
import 'package:get/get.dart';

class AddPlanta extends StatefulWidget {
  @override
  _AddPlantaState createState() => _AddPlantaState();
}

class _AddPlantaState extends State<AddPlanta> {
  final _especie = TextEditingController();
  final _observacao = TextEditingController();
  final _irrigacao = TextEditingController();
  final _icon = TextEditingController();

  var icone = '';

  final _formKey = GlobalKey<FormState>();
  var constants = Get.put(Constants());

  showEscolherIcon() {
    List<SimpleDialogOption> items = [];

    constants.imagens.forEach((imagem) {
      items.add(
        SimpleDialogOption(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Image.asset(
              imagem,
              height: 100,
            ),
          ),
          onPressed: () {
            _icon.text = imagem;
            setState(() {
              icone = imagem;
            });
            Get.back();
          },
        ),
      );
    });

    final SimpleDialog dialog = SimpleDialog(
      children: items,
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 6),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Planta'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => showEscolherIcon(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 24, bottom: 12),
                            child: Text(
                              'Clique para escolher o icone',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            child: Center(
                              child: Image.asset(
                                icone != '' ? icone : 'images/038-botanic.png',
                                height: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: TextFormField(
                        controller: _especie,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.eco),
                            border: OutlineInputBorder(),
                            labelText: 'Espécie da Planta'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a espécie da planta.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: TextFormField(
                          controller: _irrigacao,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.opacity),
                              border: OutlineInputBorder(),
                              labelText: 'Tempo de irrigação'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o tempo de irrigação.';
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: TextFormField(
                          minLines: 2,
                          maxLines: 6,
                          controller: _observacao,
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
                    Container(
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
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
