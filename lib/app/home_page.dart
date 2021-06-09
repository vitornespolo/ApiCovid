import 'package:flutter/material.dart';
import 'package:todo/app/controllers/home_controller.dart';
import 'package:todo/app/repositories/api_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = HomeController(ApiRepository());
  //ApiModel apiModel;
  //ApiRepository apiRepository = ApiRepository();
  //Future<ApiModel> resultado;

  @override
  void initState() {
    controller.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Todo'),
          actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.start();
            },
          )
        ],
        ),
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              child: controller.isLoading.value
                  ? Text('Caregando Global...')
                  : Column(children: <Widget>[
                      Container(
                        child: infoglobal(
                            'Total confirmados: ${controller.covid.value.global.totalConfirmed}',
                            Image.asset('assets/images/angry.png')),
                      ),
                      Container(
                        child: infoglobal(
                            'Total recuperados: ${controller.covid.value.global.totalRecovered}',
                            Image.asset('assets/images/happy.png')),
                      ),
                      Container(
                        child: infoglobal(
                            'Total mortes: ${controller.covid.value.global.totalDeaths}',
                            Image.asset('assets/images/sad.png')),
                      ),
                    ]),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (_) {},
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                labelStyle: TextStyle(),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            infoCountries(),
          ],
        ));
  }

  Widget infoglobal(var variavel, Image imagem) {
    return RefreshIndicator(
        child: ValueListenableBuilder(
          valueListenable: controller.covid,
          builder: (_, __, ___) {
            return Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: imagem,
                    title: Text('${variavel}'),
                  ),
                ],
              ),
            );
          },
        ),
        onRefresh: () {
          return controller.start();
        });
  }

  Widget infoCountries() {
    return ValueListenableBuilder(
        valueListenable: controller.covid,
        builder: (_, __, ___) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.covid.value.countries.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          '${controller.covid.value.countries[index].country}'),
                    ),
                    ListTile(
                      title: Text(
                          '${controller.covid.value.countries[index].date}'),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
