import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projeto_plantas/controllers/user_controller.dart';
import 'package:projeto_plantas/pages/login.dart';
import 'package:projeto_plantas/services/auth_service.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> {
  final isLoading = false.obs;
  var controller = Get.put(UserController());
  var auth = Get.put(AuthService());

  @override
  Widget build(BuildContext contextClass) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        'Editar informações',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  Container(
                    child: Form(
                      key: controller.formKey,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                              controller: controller.nome,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.people),
                                  border: OutlineInputBorder(),
                                  labelText: 'Alterar nome'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o nome.';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                              controller: controller.email,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail_outline),
                                  border: OutlineInputBorder(),
                                  labelText: 'E-mail'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Informe o e-mail.';
                                }
                                if (!(RegExp(
                                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(value))) {
                                  return 'E-mail inválido.';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                              controller: controller.senha,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                  labelText: 'Editar senha'),
                              validator: (value) {
                                if (value.isNotEmpty && value.length < 6) {
                                  return 'A senha deve conter no mínimo 6 caracteres.';
                                }
                                return null;
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: TextFormField(
                              controller: controller.confirm,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirme sua nova senha'),
                              validator: (value) {
                                if (value.isNotEmpty &&
                                    value != controller.senha.text) {
                                  return 'As senhas não são identicas';
                                }
                                return null;
                              }),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.all(25),
                          child: ElevatedButton(
                            onPressed: () async => {
                              if (controller.formKey.currentState.validate())
                                {
                                  if (await controller.editUser())
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Informações alteradas com sucesso!'),
                                        ),
                                      ),
                                      Navigator.pop(context)
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Não foi possível alterar as informações.'),
                                        ),
                                      ),
                                    }
                                }
                            },
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(400, 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: InkWell(
                            child: Text("Excluir conta",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                )),
                            onTap: () => showDialog(
                              context: context,
                              useRootNavigator: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Deseja realmente apagar sua conta?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Não'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Sim'),
                                      onPressed: () async {
                                        if (await controller.destroyUser()) {
                                          Navigator.pop(context);
                                          Navigator.of(contextClass).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Conta apagada com sucesso!'),
                                            ),
                                          );

                                          auth.resetToken();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Não foi possível apagar a conta.'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
      ),
    );
  }
}
