import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';
import 'categoria_lista.dart';

class EditProdutoBody extends StatefulWidget {
  @override
  ProdutoEditar createState() => ProdutoEditar();
}

class ProdutoEditar extends State<EditProdutoBody> {
  String nomeCidade = "";
  var _cidades = ['Eletrônicos', 'Jogos', 'Mobília'];
  var _itemSelecionado = 'Eletrônicos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: criaProdutoEditar(),
    );
  }

  criaProdutoEditar() {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar produto')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(decoration: InputDecoration(hintText: 'Nome do produto')),
            Container(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(hintText: 'Descrição do produto')),
            Container(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(hintText: 'Valor do produto')),
            Container(
              height: 10,
            ),
            TextField(decoration: InputDecoration(hintText: 'URL da imagem')),
            Container(
              height: 10,
            ),
            DropdownButtonFormField<String>(
                decoration: new InputDecoration(
                    labelText: 'Selecionar categoria',
                    labelStyle: new TextStyle(fontSize: 22.0)),
                icon: Icon(Icons.arrow_downward),
                iconSize: 15,
                elevation: 16,
                isExpanded: true,
                style: TextStyle(color: Colors.black),
                items: _cidades.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _dropDownItemSelected(novoItemSelecionado);
                  setState(() {
                    this._itemSelecionado = novoItemSelecionado;
                  });
                },
                value: _itemSelecionado),
            // Text(
            //   "A categoria selecionada foi \n$_itemSelecionado",
            //   style: TextStyle(fontSize: 20.0),
            // ),
            Container(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                height: 35,
                child: RaisedButton(
                    child: Text('Criar novo produto',
                        style: TextStyle(color: Colors.white)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }))
          ],
        ),
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

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }
}
