import 'package:aula_2_persistencia_de_dados/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {runApp(const BytebankApp());}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bytebank App',
      theme: ThemeData(
        primaryColor: Colors.green[900],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: Colors.blueAccent[700],
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: const Dashboard(),
    );
  }
}