import 'package:app/services/categoria_service.dart';
import 'package:app/services/produto_service.dart';
import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ProdutosService());
  GetIt.I.registerLazySingleton(() => CategoriasService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: ProdutoLista(),
    );
  }
}
