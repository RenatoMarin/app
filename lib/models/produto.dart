class ProdSingle {
  int prodId;
  int catId;
  String catName;
  String nome;
  String descricao;
  int valor;
  String image;

  //Construtor
  ProdSingle(
      {this.prodId, this.catId, this.catName, this.nome, this.descricao, this.valor, this.image});
  
  factory ProdSingle.fromJson(Map<String, dynamic> item){
    return ProdSingle(
      prodId: item['prodId'],
      catId: item['catId'],
      catName: item['catName'],
      nome: item['nome'],
      descricao: item['descricao'],
      valor: item['valor'],
      image: item['image']
    );
  }
}
