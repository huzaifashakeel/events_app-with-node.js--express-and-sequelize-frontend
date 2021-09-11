import 'package:events_app/screens/mainPages/loginPage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // brightness: Brightness.light,
        primaryColor: Colors.white,
        buttonColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}
