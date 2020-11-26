import 'package:app/models/categoria_para_listar.dart';
import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';

import 'categoria_adicionar.dart';

class CategoriaLista extends StatelessWidget {
  final categorias = [
    new CategoriaParaListar(
      catId: 1,
      nome: "Eletrônicos",
      descricao: "Categoria usada para eletrônicos em geral",
    ),
    new CategoriaParaListar(
      catId: 2,
      nome: "Jogos",
      descricao: "Categoria usada para jogos",
    ),
    new CategoriaParaListar(
      catId: 3,
      nome: "Mobília",
      descricao: "Categoria usada para produtos de mobília",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de categorias')),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.black,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
              icon: Icon(Icons.home, size: 35),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ProdutoLista()));
              },
            ),
            IconButton(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
              icon: Icon(Icons.store_mall_directory_outlined, size: 35),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ProdutoLista()));
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CategoriaAdicionar()));
        },
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) =>
            Divider(height: 2, color: Theme.of(context).primaryColor),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              categorias[index].nome,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(categorias[index].descricao),
          );
        },
        itemCount: categorias.length,
      ),
    );
  }
}
