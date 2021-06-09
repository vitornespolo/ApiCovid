import 'package:flutter/material.dart';

class InfoGlobal extends StatelessWidget {
  Image imagem;
  String variavel;

  
  InfoGlobal({
    Key key,
    this.imagem,
    this.variavel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: imagem,
            title: Text('$variavel'),
          ),
        ],
      ),
    );
  }
}
