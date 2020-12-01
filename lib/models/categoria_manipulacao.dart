import 'package:flutter/cupertino.dart';

class CategoriaManipulacao {
  String nome;
  String descricao;

  //Construtor
  CategoriaManipulacao(
      {@required this.nome,
      @required this.descricao,
});

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "descricao": descricao,
    };
  }
}
