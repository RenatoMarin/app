import 'package:flutter/material.dart';

class ProdutoLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de produtos')),
      persistentFooterButtons: <Widget>[
        Container(
          width: MediaQuery.of(context).copyWith().size.width,
          child: Row(
            children: [
              Expanded(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // conteudo aqui
                  },
                  label: Text('Produto'),
                  icon: Icon(Icons.my_library_add_rounded),
                  backgroundColor: Colors.black,
                ),
              ),
              Expanded(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // conteudo aqui
                  },
                  label: Text('Categoria'),
                  icon: Icon(Icons.my_library_add_rounded),
                  backgroundColor: Colors.black,
                ),
              )
            ],
          ),
        )
      ],
      body: ListView.separated(
        separatorBuilder: (_, __) =>
            Divider(height: 2, color: Theme.of(context).primaryColor),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              'Produto Nome',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text('Produto categoria'),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,
                minHeight: 100,
                maxWidth: 100,
                maxHeight: 100,
              ),
              child: Image.asset('assets/images/prod.jpg', fit: BoxFit.cover),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
