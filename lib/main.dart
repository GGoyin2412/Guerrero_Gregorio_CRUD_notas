import 'package:flutter/material.dart';
import 'package:crud_flutter_goyo/paginas/pagina_lista.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mateapp',
      debugShowCheckedModeBanner: false,
      home: ListPages(),
    );
  }
}