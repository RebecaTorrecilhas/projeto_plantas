import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirm = TextEditingController();

  var isLoading = false.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Bem-Vindo!',
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Satisfy',
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            'Cadastre-se para começar a cuidar de suas plantas, registrando os cuidados especiais que cada uma deve ter! ',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            child: TextFormField(
                                controller: _nome,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.people),
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome'),
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
                                controller: _email,
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
                                controller: _senha,
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                    labelText: 'Informe sua senha'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe a senha.';
                                  }
                                  if (value.length < 6) {
                                    return 'A senha deve conter no mínimo 6 caracteres.';
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            child: TextFormField(
                                controller: _confirm,
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(),
                                    labelText: 'Confirme sua senha'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Informe a confirmação de senha.';
                                  }
                                  if (value != _senha.text) {
                                    return 'As senhas não são identicas';
                                  }
                                  return null;
                                }),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.all(25),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    isLoading.value = true;

                                    if (await AuthService.to.register(
                                        _nome.text, _email.text, _senha.text)) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Não foi possível cadastrar.'),
                                        ),
                                      );
                                    }

                                    isLoading.value = false;
                                  }
                                },
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(400, 50),
                                ),
                              )),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
