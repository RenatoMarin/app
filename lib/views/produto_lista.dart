import 'package:flutter/material.dart';

class ProdutoLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de produtos')),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.black,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
              icon: Icon(Icons.home, size: 35),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 20.0),
              icon: Icon(Icons.app_registration, size: 35),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
      ),
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
