import 'dart:convert';
import 'package:app/models/api_response.dart';
import 'package:app/models/produto.dart';
import 'package:app/models/produtos_adicionar.dart';
import 'package:app/models/produtos_manipulacao.dart';
import 'package:app/models/produtos_para_listar.dart';
import 'package:http/http.dart' as http;

class ProdutosService {
  static const API = 'http://10.0.2.2:3000';
  static const headers = {'Content-Type': 'application/json'};

  //HTTP request são assíncronos
  Future<APIResponse<List<ProdutosParaListar>>> getProdutoLista() {
    return http.get(API + '/produtos').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final produtos = <ProdutosParaListar>[];
        for (var item in jsonData) {
          produtos.add(ProdutosParaListar.fromJson(item));
        }
        return APIResponse<List<ProdutosParaListar>>(data: produtos);
      }
      return APIResponse<List<ProdutosParaListar>>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<List<ProdutosParaListar>>(
        error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<List<ProdSingle>>> getProdSingle(String id) {
    return http.get(API + '/produtos/' + id).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final produtos = <ProdSingle>[];
        for (var item in jsonData) {
          produtos.add(ProdSingle.fromJson(item));
        }
        return APIResponse<List<ProdSingle>>(data: produtos);
      }
      return APIResponse<List<ProdSingle>>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<List<ProdSingle>>(
        error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<bool>> criarProduto(ProdutosParaAdicionar item) {
    return http
        .post(API + '/produtos',
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201 || data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'Um erro aconteceu 5'));
  }

  Future<APIResponse<bool>> atualizarProduto(String id, ProdutoManipulation item) {
    return http.put(API + '/produtos/' + id , headers: headers, body: json.encode(item.toJson())) .then((data) {
      if (data.statusCode == 200 || data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'Um erro aconteceu 5'));
  }

  Future<APIResponse<bool>> deletarProduto(String id) {
    return http
        .delete(API + '/produtos/' + id, headers: headers,).then((data) {
      if (data.statusCode == 200 || data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'Um erro aconteceu 5'));
  }

}
