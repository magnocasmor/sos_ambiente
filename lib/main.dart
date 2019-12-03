import 'package:flutter/material.dart';
import 'package:sos_ambiente/screens/login_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF01CA9D),
        accentColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
