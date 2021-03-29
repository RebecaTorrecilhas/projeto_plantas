import 'package:flutter/material.dart';
import 'package:projeto_plantas/pages/forgotPassword.dart';
import 'package:projeto_plantas/pages/home.dart';
import 'package:projeto_plantas/pages/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Image.asset(
                'images/038-botanic.png',
                height: 150,
              ),
            ),
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                        controller: _senha,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            labelText: 'Senha'),
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
                          if (_formKey.currentState.validate())
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Home(),
                                ),
                              ),
                            }
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350, 50),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: InkWell(
                        child: Text("Cadastrar-se",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            )),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Register(),
                            ),
                          );
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: InkWell(
                        child: Text("Esqueceu senha?",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                            )),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ForgotPassword(),
                            ),
                          );
                        },
                      ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
