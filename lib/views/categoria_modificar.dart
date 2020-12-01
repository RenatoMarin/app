import 'package:flutter/material.dart';


class CateogiaModificar extends StatelessWidget {

  final String catId;
  
  bool get isEditing => catId != null;

  CateogiaModificar({this.catId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Criar categoria' : 'Editar categoria')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Nome da categoria'
              ),
            ),
            Container(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Descrição da categoria'
              ),
            ),
            Container(height: 16),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Criar', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}