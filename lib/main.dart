import 'package:flutter/material.dart';
import 'pages/metas_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metas de Exercício',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MetasPage(),
    );
  }
}
