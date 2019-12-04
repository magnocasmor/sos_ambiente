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
        primarySwatch: MaterialColor(0xFF4FBA46, {
          50: Color(0xFFeaf7e9),
          100: Color(0xFFcaeac8),
          200: Color(0xFFa7dda3),
          300: Color(0xFF84cf7e),
          400: Color(0xFF69c462),
          500: Color(0xFF4fba46),
          600: Color(0xFF48b33f),
          700: Color(0xFF3fab37),
          800: Color(0xFF36a32f),
          900: Color(0xFF269420),
        }),
        // accentColor: Colors.white,
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
