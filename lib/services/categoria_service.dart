import 'package:app/models/categoria_para_listar.dart';

class CategoriasService {
  //HTTP request
  List<CategoriaParaListar> getCategoriaLista(){
    return [
      new CategoriaParaListar(
      catId: 1,
      nome: "Eletrônicos",
      descricao: "Categoria usada para eletrônicos em geral",
      ),
      new CategoriaParaListar(
        catId: 2,
        nome: "Jogos",
        descricao: "Categoria usada para jogos",
      ),
      new CategoriaParaListar(
        catId: 3,
        nome: "Mobília",
        descricao: "Categoria usada para produtos de mobília",
      ),
    ];
  }
}