import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/plants_controller.dart';
import '../constants.dart';

class EditPlanta extends StatefulWidget {
  final planta;

  EditPlanta({this.planta}) : super();

  @override
  _EditPlantaState createState() => _EditPlantaState();
}

class _EditPlantaState extends State<EditPlanta> {
  var first = true;
  var icone = '';
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
    if (first) {
      controller.especie.text = widget.planta['especie'];
      controller.irrigar.text = widget.planta['irrigar'];
      controller.obs.text = widget.planta['obs'];
      controller.icon.text = widget.planta['icon'];

      setState(() {
        icone = widget.planta['icon'];
        first = false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Planta'),
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
                        controller: controller.especie,
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
                          controller: controller.irrigar,
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
                          controller: controller.obs,
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
                        onPressed: () async {
                          if (controller.formKey.currentState.validate()) {
                            if (await controller.edit(widget.planta['id'])) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Planta editada com sucesso!'),
                                ),
                              );

                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Não foi possível editar a planta.'),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          'Atualizar',
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
