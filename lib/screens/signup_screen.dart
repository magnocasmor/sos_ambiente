import 'package:flutter/material.dart';
import 'package:sos_ambiente/screens/main_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastre-se',
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Form(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.only(
                    bottom: 8.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: RaisedButton(
                      child: Text(
                        'CADASTRAR',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                            (route) => false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
