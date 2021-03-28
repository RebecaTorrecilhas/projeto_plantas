import 'package:flutter/material.dart';
import 'package:projeto_plantas/pages/login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueceu a senha'),
      ),
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
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
              )
              )
            ),
            Container(
              child: Form(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
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
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Login(),
                          ),
                        ),
                      },
                      child: Text(
                        'Enviar',
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
      ),
    );
  }
}
