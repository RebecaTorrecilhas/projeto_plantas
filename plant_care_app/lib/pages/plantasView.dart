import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../controllers/plants_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './editPlanta.dart';

class PlantasView extends StatefulWidget {
  final planta;
  PlantasView({Key key, this.planta}) : super(key: key);

  @override
  _PlantasViewState createState() => _PlantasViewState();
}

class _PlantasViewState extends State<PlantasView> {
  var controller = Get.put(PlantsController());

  File arquivo;
  final picker = ImagePicker();

  Future getFileFromCamera() async {
    final file = await picker.getImage(source: ImageSource.camera);
    if (file != null) {
      await controller.addImagem(widget.planta['id'], file);
    }
  }

  Future getFileFromGallery() async {
    final file = await picker.getImage(source: ImageSource.gallery);

    if (file != null) {
      await controller.addImagem(widget.planta['id'], file);
    }
  }

  opcaoFoto() {
    List<SimpleDialogOption> items = [
      SimpleDialogOption(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Camera',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        onPressed: () {
          getFileFromCamera();
          Get.back();
        },
      ),
      SimpleDialogOption(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Galeria',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        onPressed: () {
          getFileFromGallery();
          Get.back();
        },
      )
    ];

    final SimpleDialog dialog = SimpleDialog(
      children: items,
      insetPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 4),
    );

    showDialog(context: context, builder: (_) => dialog);
  }

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
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () async {
                  await controller.delete(widget.planta['id']);
                  Navigator.pop(context);
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
          widget.planta['especie'],
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Editar'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditPlanta(planta: widget.planta),
                        ),
                      );
                    }),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Excluir'),
                  onTap: () async {
                    deletePlanta(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                widget.planta['icon'],
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
                widget.planta['obs'],
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
                widget.planta['irrigar'],
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            opcaoFoto();
          },
          child: const Icon(Icons.camera_alt)),
    );
  }
}
