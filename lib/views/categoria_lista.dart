import 'package:app/models/api_response.dart';
import 'package:app/models/categoria_para_listar.dart';
import 'package:app/services/categoria_service.dart';
import 'package:app/views/produto_lista.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'categoria_deletar.dart';
import 'categoria_modificar.dart';

class CategoriaLista extends StatefulWidget {
  @override
  _CategoriaListaState createState() => _CategoriaListaState();
}

class _CategoriaListaState extends State<CategoriaLista> {
  CategoriasService get serviceCatList => GetIt.I<CategoriasService>();
  APIResponse<List<CategoriaParaListar>> _apiResponse;
  int catId;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await serviceCatList.getCategoriaLista();
    setState(() {
      _isLoading = false;
    });
  }

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
            .push(MaterialPageRoute(builder: (_) => CateogiaModificar()))
            .then((_) {
              _fetchCategories();
            });
        },
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(height: 2, color: Theme.of(context).primaryColor),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].catId),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                },
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                  context: context,
                  builder: (_) => CategoriaDeletar());
                  if(result){
                    final deleteResultCat = await serviceCatList.deletarCategoria(_apiResponse.data[index].catId.toString());
                    var message;
                    if(deleteResultCat != null && deleteResultCat.data == true){
                      message = 'A categoria foi deletada';
                    } else {
                      message = deleteResultCat?.errorMessage ?? 'Um erro acorreu';
                    }
                    showDialog(
                      context: context, builder: (_) => AlertDialog(
                        title: Text('Pronto'),
                        content: Text(message),
                        actions: <Widget>[
                          FlatButton(child: Text('Ok'), onPressed: () {
                            Navigator.of(context).pop();
                          }),
                        ]
                      ));
                    return deleteResultCat?.data ?? false;
                  }
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    _apiResponse.data[index].nome,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Descrição: '+ _apiResponse.data[index].descricao),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => CateogiaModificar(catId: _apiResponse.data[index].catId))).then((data){
                      _fetchCategories();
                    });
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      )
    );
  }
}
