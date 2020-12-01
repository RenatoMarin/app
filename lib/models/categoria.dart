class Categoria {
  int catId;
  String nome;
  String descricao;

  //Construtor
  Categoria(
      {this.catId, this.nome, this.descricao, });
  
  factory Categoria.fromJson(Map<String, dynamic> item){
    return Categoria(
      catId: item['catId'],
      nome: item['nome'],
      descricao: item['descricao'],
    );
  }
}
