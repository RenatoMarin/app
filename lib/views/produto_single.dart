import 'package:app/models/produto.dart';
import 'package:app/views/produto_editar.dart';
import 'package:flutter/widgets.dart';
import 'package:app/models/api_response.dart';
import 'package:app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'categoria_lista.dart';

class SingleProdutoBody extends StatefulWidget {
  final int varId;

  SingleProdutoBody({this.varId});

  @override
  _ProdutoListaState createState() => _ProdutoListaState();
}

class _ProdutoListaState extends State<SingleProdutoBody> {
  ProdutosService get service => GetIt.I<ProdutosService>();
  APIResponse<List<ProdSingle>> _apiResponse;
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
    _apiResponse = await service.getProdSingle(widget.varId.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Single de produtos')),
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
          child: const Icon(Icons.edit_outlined),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => EditProdutoBody(varId: widget.varId))).then((data) {
                  _fetchProducts();
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
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(children: [
                    Image.network(
                      _apiResponse.data[index].image, 
                      fit: BoxFit.cover
                    ),
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 5, top: 10),
                            child: Text(
                              _apiResponse.data[index].nome,
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
                              'Categoria: ' + _apiResponse.data[index].catName,
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
                              'Valor: ' +_apiResponse.data[index].valor.toString() + ' reais',
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
                              _apiResponse.data[index].descricao,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      )
    );
  }
}
