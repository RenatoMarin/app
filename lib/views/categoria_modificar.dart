import 'package:app/models/categoria.dart';
import 'package:app/models/categoria_manipulacao.dart';
import 'package:app/services/categoria_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CateogiaModificar extends StatefulWidget {
  final int catId;
  CateogiaModificar({this.catId});

  @override
  _CateogiaModificarState createState() => _CateogiaModificarState();
}

class _CateogiaModificarState extends State<CateogiaModificar> {
  CategoriasService get catService => GetIt.I<CategoriasService>();
  bool get isEditing => widget.catId != null;

  String errorMessage;
  Categoria categoria;

  TextEditingController _nomeCatController = TextEditingController();
  TextEditingController _descriptionCatController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      catService.getCategoria(widget.catId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? 'Um erro ocorreu';
        }
        categoria = response.data;
        _nomeCatController.text = categoria.nome;
        _descriptionCatController.text = categoria.descricao;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? 'Editar categoria' : 'Criar categoria')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: <Widget>[
            TextField(
              controller: _nomeCatController,
              decoration: InputDecoration(hintText: 'Nome da categoria'),
            ),
            Container(height: 8),
            TextField(
              controller: _descriptionCatController,
              decoration:
                  InputDecoration(hintText: 'Descrição da categoria'),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child:
                    Text('Criar', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if(isEditing) {
                    setState(() {
                      _isLoading = true;
                    });
                    final categoria = CategoriaManipulacao (
                      nome: _nomeCatController.text,
                      descricao: _descriptionCatController.text
                    );
                    final result = await catService.atualizarCategoria(widget.catId.toString(), categoria);
                    setState(() {
                      _isLoading = false;
                    });
                    final title = 'Pronto';
                    final text = result.error ? result.errorMessage ?? 'Um erro aconteceu' : 'A categoria foi atualizada!';
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    ).then((data) {
                      if(result.data){
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    final categoria = CategoriaManipulacao (
                      nome: _nomeCatController.text,
                      descricao: _descriptionCatController.text
                    );
                    final result = await catService.createCategoria(categoria);
                    setState(() {
                      _isLoading = false;
                    });
                    final title = 'Pronto';
                    final text = result.error ? result.errorMessage ?? 'Um erro aconteceu' : 'A categoria foi criada!';
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                    ).then((data) {
                      if(result.data){
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
