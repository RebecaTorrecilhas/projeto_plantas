import 'package:flutter/material.dart';
import 'package:projeto_plantas/services/auth_service.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueceu a senha'),
      ),
      body: Obx(
        () => isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 20),
                      child: Image.asset(
                        'images/038-botanic.png',
                        height: 150,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                            'Para recuperar seu acesso, digite o email cadastrado. ',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(24),
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
                                  return null;
                                }),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.all(25),
                            child: ElevatedButton(
                              onPressed: () async {
                                isLoading.value = true;
                                
                                if (await AuthService.to.forgot(_email.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('E-mail enviado com sucesso!'),
                                    ),
                                  );

                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('E-mail inexistente :( '),
                                    ),
                                  );
                                }

                                isLoading.value = false;
                              },
                              child: Text(
                                'Enviar',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(400, 50),
                              ),
                            ),
                          ),
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
