import 'package:flutter/cupertino.dart';

class ProdutosParaAdicionar {
  int catId;
  String catName;
  String nome;
  String descricao;
  int valor;
  String image;

  //Construtor
  ProdutosParaAdicionar(
      {@required this.catId,
      @required this.catName,
      @required this.nome,
      @required this.descricao,
      @required this.valor,
      @required this.image});

  Map<String, dynamic> toJson() {
    return {
      "catId": catId,
      "catName": catName,
      "nome": nome,
      "descricao": descricao,
      "valor": valor,
      "image": image
    };
  }
}
