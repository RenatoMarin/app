class CategoriaParaListar {
  int catId;
  String nome;
  String descricao;
  //Construtor
  CategoriaParaListar({this.catId, this.nome, this.descricao});

  factory CategoriaParaListar.fromJson(Map<String, dynamic> item){
    return CategoriaParaListar(
      catId: item['catId'],
      nome: item['nome'],
      descricao: item['descricao'],
    );
  }
}
