import 'package:flutter/material.dart';
import 'package:projeto_plantas/pages/home.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Bem-Vindo!',
              style: TextStyle(
                fontSize: 40,
              ),
            )),
            Padding(
              padding: EdgeInsets.all(20), 
              child: Text(
                'Cadastre-se para começar a cuidar de suas plantas, registrando os cuidados especiais que cada uma deve ter! ',
               style: TextStyle(
                fontSize: 18,
              )
              )
            ),
            Container(
              child: Form(
                child: Column(children: [
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    
                    child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            border: OutlineInputBorder(),
                            labelText: 'Nome'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe o e-mail.';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            labelText: 'Informe sua senha'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a senha.';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            labelText: 'Confirme sua senha'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe a senha.';
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
                            MaterialPageRoute(builder: (_) => Home()),
                          ),
                        },
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                        ),
                      )),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
