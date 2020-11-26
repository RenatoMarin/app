import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';
import 'categoria_lista.dart';

class CategoriaAdicionar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar categoria')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: <Widget>[
          TextField(decoration: InputDecoration(hintText: 'Nome da categoria')),
          Container(
            height: 10,
          ),
          TextField(
              decoration: InputDecoration(hintText: 'Descrição da categoria')),
        ]),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.black,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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
              icon: Icon(Icons.app_registration, size: 35),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CategoriaLista()));
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
    );
  }
}
