import 'package:app/models/produtos_para_listar.dart';
import 'package:app/views/produto_adicionar.dart';
import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';

import 'categoria_lista.dart';

class SingleProdutoBody extends StatefulWidget {
  @override
  ProdutoSingle createState() => ProdutoSingle();
}

class ProdutoSingle extends State<SingleProdutoBody> {
  final produtos = [
    new ProdutosParaListar(
      prodId: 1,
      nome: "Controle PlayStation",
      descricao: "Controle oficial do playStation 5",
      valor: 550,
      image: "assets/images/prod.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: singleProtuto(),
    );
  }

  singleProtuto() {
    return Scaffold(
        appBar: AppBar(title: Text('Nome do produto')),
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
                icon: Icon(Icons.store_mall_directory_outlined, size: 35),
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
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit_outlined),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddProdutoBody()));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Image.asset(
              'assets/images/prod.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      'Nome do produto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: 
                    Text(
                      'Categoria do produto',
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Valor do produto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut nec fringilla ante, sed vestibulum lorem. Donec vel augue lacus. Vestibulum ac molestie purus. Aenean scelerisque felis placerat suscipit aliquam. Aenean odio orci, euismod nec dui eu, commodo ultrices leo. Donec quis dictum enim, vel rutrum est. Cras eu lacinia nulla. In est augue, placerat sed dictum eu, pretium nec felis. Phasellus convallis lacus tellus, eu aliquam mauris efficitur at.',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            )
          ]
        )
      )
    );
  }
}
