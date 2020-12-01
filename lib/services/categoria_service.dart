import 'dart:convert';
import 'package:app/models/api_response.dart';
import 'package:app/models/categoria.dart';
import 'package:app/models/categoria_manipulacao.dart';
import 'package:app/models/categoria_para_listar.dart';
import 'package:http/http.dart' as http;

class CategoriasService {
  static const API = 'http://10.0.2.2:3000';
  static const headers = {'Content-Type':'application/json'};

  Future<APIResponse<List<CategoriaParaListar>>> getCategoriaLista() {
    return http.get(API + '/categoria').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final produtos = <CategoriaParaListar>[];
        for (var item in jsonData) {
          produtos.add(CategoriaParaListar.fromJson(item));
        }
        return APIResponse<List<CategoriaParaListar>>(data: produtos);
      }
      return APIResponse<List<CategoriaParaListar>>(
          error: true, errorMessage: 'Um erro aconteceu 5');
    }).catchError((_) => APIResponse<List<CategoriaParaListar>>(
        error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<Categoria>> getCategoria(String catID) {
    return http.get(API + '/categoria/' + catID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Categoria>(data: Categoria.fromJson(jsonData[0]));
      }
      return APIResponse<Categoria>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<Categoria>(error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<bool>> createCategoria(CategoriaManipulacao item) {
    return http.post(API + '/categoria', headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200 || data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<bool>> atualizarCategoria(String catId, CategoriaManipulacao item) {
    return http.put(API + '/categoria/' + catId, headers: headers, body: json.encode(item.toJson())).then((data) {
      if (data.statusCode == 200 || data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 2'));
  }

  Future<APIResponse<bool>> deletarCategoria(String catId) {
    return http.delete(API + '/categoria/' + catId, headers: headers).then((data) {
      if (data.statusCode == 200 || data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 5');
    })
    .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'Um erro aconteceu 2'));
  }
}