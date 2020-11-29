import 'package:app/models/produtos_para_listar.dart';
import 'package:app/views/produto_adicionar.dart';
import 'package:app/views/produto_single.dart';
import 'package:flutter/material.dart';

import 'categoria_lista.dart';

class ProdutoLista extends StatelessWidget {
  final produtos = [
    new ProdutosParaListar(
      prodId: 1,
      nome: "Controle PlayStation",
      descricao: "Controle oficial do playStation 5",
      valor: 550,
      image: "assets/images/prod.jpg",
    ),
    new ProdutosParaListar(
      prodId: 2,
      nome: "Controle XBox",
      descricao: "Controle oficial XBox",
      valor: 500,
      image: "assets/images/xbox.jpg",
    ),
    new ProdutosParaListar(
      prodId: 3,
      nome: "Controle nintendo Switch",
      descricao: "Controle oficial do nintendo Switch",
      valor: 850,
      image: "assets/images/switch.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de produtos')),
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
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
              icon: Icon(Icons.app_registration, size: 35),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CategoriaLista()));
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
              .push(MaterialPageRoute(builder: (_) => AddProdutoBody()));
        },
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) =>
            Divider(height: 2, color: Theme.of(context).primaryColor),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              produtos[index].nome,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(produtos[index].descricao),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                minHeight: 100,
                maxWidth: 100,
                maxHeight: 100,
              ),
              child: Image.asset(produtos[index].image, fit: BoxFit.cover),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SingleProdutoBody()));
            },
          );
        },
        itemCount: produtos.length,
      ),
    );
  }
}
