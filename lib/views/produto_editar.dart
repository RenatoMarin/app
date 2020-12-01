import 'package:app/models/produtos_manipulacao.dart';
import 'package:app/services/produto_service.dart';
import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'categoria_lista.dart';

class EditProdutoBody extends StatefulWidget {
  final int varId;
  EditProdutoBody({this.varId});

  @override
  ProdutoEditar createState() => ProdutoEditar();
}

class CategoId {
  const CategoId(this.catID,this.catName);
  final int catID;
  final String catName;
}

class ProdutoEditar extends State<EditProdutoBody> {
  CategoId selectedCatego;
  List<CategoId> categos = <CategoId>[const CategoId(1,'Jogos'), const CategoId(2,'Eletrônicos')];
  final _formKey = GlobalKey<FormState>();

  ProdutosService get produtoService => GetIt.I<ProdutosService>();

  @override
  void initState() {
    selectedCatego=categos[0];
    super.initState();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _urlController = TextEditingController();

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
            Form (
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nome do produto'
                    ),
                    validator: (text) {
                      if (text.length < 5 || text.length > 100) {
                        return 'O nome do produto deve ser maior que 5 e menor que 100 caracteres.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(hintText: 'Descrição do produto'),
                    validator: (text) {
                      if (text.length < 10) {
                        return 'A descrição deve ter ao menos 10 caracteres.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _valorController,
                    decoration: InputDecoration(hintText: 'Valor do produto'),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (int.parse(text) <= 0) {
                        return 'O valor não pode ser de 0 reais.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: 'URL da imagem'
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return 'O campo de imagem não pode estar vazio.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                ],
              )
            ),
            new Center(
              child: new DropdownButtonFormField<CategoId>(
                decoration: new InputDecoration(
                  labelText: 'Selecionar categoria',
                  labelStyle: new TextStyle(fontSize: 22.0)
                ),
                icon: Icon(Icons.arrow_downward),
                iconSize: 15,
                elevation: 16,
                isExpanded: true,
                style: TextStyle(color: Colors.black),
                value: selectedCatego,
                onChanged: (CategoId newValue) {
                  setState(() {
                    selectedCatego = newValue;
                  });
                },
                items: categos.map((CategoId categoId) {
                  return new DropdownMenuItem<CategoId>(
                    value: categoId,
                    child: new Text(
                      categoId.catName,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              )
            ),
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    final produto = ProdutoManipulation(
                      catId: selectedCatego.catID,
                      catName: selectedCatego.catName,
                      nome: _nameController.text,
                      descricao: _descricaoController.text,
                      valor: int.parse(_valorController.text),
                      image:_urlController.text
                    );
                    final result = await produtoService.atualizarProduto(widget.varId.toString(), produto);
                    final title = 'Done';
                    final text = result.error ? (result.errorMessage ?? 'Um erro aconteceu') : 'Seu produto foi atualizado com sucesso';
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProdutoLista()));
                            }
                          )
                        ]
                      )
                    );
                  }
                }
              )
            )
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
}
