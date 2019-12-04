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
        primaryColor: Color(0xFF4FBA46),
        accentColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          // textTheme: TextTheme(
          //   title: TextStyle(color: Colors.white, fontSize: 18),
          // ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
        buttonTheme: ButtonThemeData(height: 48.0),
      ),
      home: LoginScreen(),
    );
  }
}
