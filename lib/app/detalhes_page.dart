import 'package:flutter/material.dart';
import 'package:todo/app/Widgets/infoglobal_widget.dart';
import 'package:todo/app/models/country_model.dart';
import 'package:todo/app/models/todo_model.dart';

class DetalhesPage extends StatefulWidget {
  Countries countryModel;
  DetalhesPage({Key key, this.countryModel}) : super(key: key);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pais Selecionado'),
      ),
      body: Column(children: <Widget>[
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Dados do: ${widget.countryModel.country} - ${widget.countryModel.countryCode}'
              '\n ${widget.countryModel.date}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        Divider(),
        Container(
          child: InfoGlobal(
              variavel:
                  'Total confirmados: ${widget.countryModel.totalConfirmed}',
              imagem: Image.asset('assets/images/angry.png')),
        ),
        Container(
          child: InfoGlobal(
              variavel:
                  'Total recuperados: ${widget.countryModel.totalRecovered}',
              imagem: Image.asset('assets/images/happy.png')),
        ),
        Container(
          child: InfoGlobal(
              variavel: 'Total mortes: ${widget.countryModel.totalDeaths}',
              imagem: Image.asset('assets/images/sad.png')),
        ),
      ]),
    );
  }
}
