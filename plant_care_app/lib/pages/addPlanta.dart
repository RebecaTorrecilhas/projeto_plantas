import 'package:flutter/material.dart';
import 'package:projeto_plantas/constants.dart';
import 'package:get/get.dart';
import '../controllers/plants_controller.dart';

class AddPlanta extends StatefulWidget {
  @override
  _AddPlantaState createState() => _AddPlantaState();
}

class _AddPlantaState extends State<AddPlanta> {
  var icone = 'images/038-botanic.png';
  var constants = Get.put(Constants());
  var controller = Get.put(PlantsController());

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
            controller.icon.text = imagem;

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
                  key: controller.formKey,
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
                                icone,
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
                        controller: controller.especie,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.eco),
                            border: OutlineInputBorder(),
                            labelText: 'Esp??cie da Planta'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a esp??cie da planta.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: TextFormField(
                          controller: controller.irrigar,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.opacity),
                              border: OutlineInputBorder(),
                              labelText: 'Tempo de irriga????o'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o tempo de irriga????o.';
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
                          controller: controller.obs,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.article),
                              border: OutlineInputBorder(),
                              labelText: 'Observa????es'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe as observa????es';
                            }
                            return null;
                          }),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(25),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState.validate()) {
                            if (await controller.add()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Planta adicionada com sucesso!'),
                                ),
                              );

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'N??o foi poss??vel adicionar a planta.'),
                                ),
                              );
                            }
                          }
                        },
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
