import 'dart:convert';

import 'package:app/models/api_response.dart';
import 'package:app/models/produtos_adicionar.dart';
import 'package:app/models/produtos_para_listar.dart';
import 'package:http/http.dart' as http;

class ProdutosService {
  static const API = 'http://10.0.2.2:3000';
  static const headers = {
    'Content-Type' : 'application/json'
  };

  //HTTP request são assíncronos
  Future<APIResponse<List<ProdutosParaListar>>> getProdutoLista() {
    return http.get(API + '/produtos').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final produtos = <ProdutosParaListar>[];
        for (var item in jsonData) {
          final produto = ProdutosParaListar(
              prodId: item['prodId'],
              catId: item['catId'],
              catName: item['catName'],
              nome: item['nome'],
              descricao: item['descricao'],
              valor: item['valor'],
              image: item['image']);
          produtos.add(produto);
        }
        return APIResponse<List<ProdutosParaListar>>(data: produtos);
      }
      return APIResponse<List<ProdutosParaListar>>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<List<ProdutosParaListar>>(error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<bool>> criarProduto(ProdutosParaAdicionar item){
    return http.post(API + '/produtos', headers:headers, body: json.encode(item.toJson())).then((data) {
      if(data.statusCode == 201 || data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 5'));
  }
}
