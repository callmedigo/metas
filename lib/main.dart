import 'package:flutter/material.dart';
import 'pages/metas_page.dart';  // Ajuste conforme seu projeto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metas de Exercício',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Metas'),
          actions: [
            Row(
              children: [
                const Icon(Icons.light_mode),
                Switch(
                  value: isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      isDarkMode = val;
                    });
                  },
                ),
                const Icon(Icons.dark_mode),
                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
        body: const MetasPage(),
      ),
    );
  }
}
