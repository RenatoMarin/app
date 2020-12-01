import 'dart:convert';
import 'package:app/models/api_response.dart';
import 'package:app/models/categoria_para_listar.dart';
import 'package:http/http.dart' as http;

class CategoriasService {
  static const API = 'http://10.0.2.2:3000';
  static const headers = {'Content-Type': 'application/json'};

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
  
  //HTTP request
  // List<CategoriaParaListar> getCategoriaLista(){
  //   return [
  //     new CategoriaParaListar(
  //     catId: 1,
  //     nome: "Eletrônicos",
  //     descricao: "Categoria usada para eletrônicos em geral",
  //     ),
  //     new CategoriaParaListar(
  //       catId: 2,
  //       nome: "Jogos",
  //       descricao: "Categoria usada para jogos",
  //     ),
  //     new CategoriaParaListar(
  //       catId: 3,
  //       nome: "Mobília",
  //       descricao: "Categoria usada para produtos de mobília",
  //     ),
  //   ];
  // }
}