import 'package:flutter/widgets.dart';
import 'package:app/models/api_response.dart';
import 'package:app/models/produtos_para_listar.dart';
import 'package:app/services/produto_service.dart';
import 'package:app/views/produto_adicionar.dart';
import 'package:app/views/produto_deletar.dart';
import 'package:app/views/produto_single.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'categoria_lista.dart';

class ProdutoLista extends StatefulWidget {
  @override
  _ProdutoListaState createState() => _ProdutoListaState();
}

class _ProdutoListaState extends State<ProdutoLista> {
  ProdutosService get service => GetIt.I<ProdutosService>();
  APIResponse<List<ProdutosParaListar>> _apiResponse;
  int varId;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getProdutoLista();
    setState(() {
      _isLoading = false;
    });
  }

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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CategoriaLista()));
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
                  key: ValueKey(_apiResponse.data[index].prodId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    //showDialog é FUTURE
                    final result = await showDialog(
                        context: context, builder: (_) => ProdutoDeletar());
                    if (result){
                      final deleteResult = await service.deletarProduto(_apiResponse.data[index].prodId.toString());
                      var message;
                      if(deleteResult != null && deleteResult.data == true) {
                        message = "Produto foi deletado!";
                      } else {
                        message = deleteResult?.errorMessage ?? "Um erro ocorreu";
                      }
                      showDialog(
                        context: context, builder: (_) => AlertDialog(
                          title: Text('Pronto'),
                          content: Text(message),
                          actions: <Widget>[
                            FlatButton(child: Text('Ok'), onPressed: () {
                              Navigator.of(context).pop();
                            })
                          ],
                      ));

                      return deleteResult?.data ?? false;
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
                    subtitle: Text('Categoria: '+ _apiResponse.data[index].catName),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        minHeight: 100,
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      child: Image.network(
                        _apiResponse.data[index].image, 
                        fit: BoxFit.cover
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SingleProdutoBody(varId: _apiResponse.data[index].prodId)));
                    },
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}
