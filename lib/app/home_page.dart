import 'package:flutter/material.dart';
import 'package:todo/app/controllers/home_controller.dart';
import 'package:todo/app/detalhes_page.dart';
import 'package:todo/app/models/todo_model.dart';
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
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                builder: (_, __) {
                  return ValueListenableBuilder(
                    builder: (_, __, ___) {
                      if (controller.isLoading.value) {
                        return Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          ),
                        );
                      }
                      return ValueListenableBuilder(
                        builder: (_, __, ___) {
                          return Column(
                            children: [
                              Column(children: <Widget>[
                                Text(
                                    'Dados Globais: ${controller.covid.value.global.date}'),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: TextField(
                                    onChanged: controller.sarchCautrins,
                                    textInputAction: TextInputAction.go,
                                    decoration: InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal),
                                      ),
                                      hintText: 'Search Country',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: infoCountries()),
                            ],
                          );
                        },
                        valueListenable: controller.covid,
                      );
                    },
                    valueListenable: controller.isLoading,
                  );
                },
              ),
            ),

            // Container(
            //   child: controller.isLoading.value
            //       ? Text('Caregando Global...')
            //       : Column(children: <Widget>[
            //           Container(
            //             child: infoglobal(
            //                 'Total confirmados: ${controller.covid.value.global.totalConfirmed}',
            //                 Image.asset('assets/images/angry.png')),
            //           ),
            //           Container(
            //             child: infoglobal(
            //                 'Total recuperados: ${controller.covid.value.global.totalRecovered}',
            //                 Image.asset('assets/images/happy.png')),
            //           ),
            //           Container(
            //             child: infoglobal(
            //                 'Total mortes: ${controller.covid.value.global.totalDeaths}',
            //                 Image.asset('assets/images/sad.png')),
            //           ),
            //         ]),
            // ),
            // SizedBox(height: 15),
            // TextFormField(
            //   onChanged: (_) {},
            //   decoration: InputDecoration(
            //     labelText: 'Pesquisar',
            //     prefixIcon: Icon(Icons.search),
            //     labelStyle: TextStyle(),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // Divider(),

            //infoCountries(),
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
                    title: Text('$variavel'),
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
              return Card(
                child: Container(
                  child: ListTile(
                    title: Text(
                        '${controller.covid.value.countries[index].countryCode}'),
                    subtitle: Text(
                      '${controller.covid.value.countries[index].date}',
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      print('clicou');
                      print(controller.covid.value.countries[index].country);
                      Navigator.of(context).push<Countries>(
                        MaterialPageRoute(builder: (context) {
                          return DetalhesPage(
                              countryModel: controller.covid.value
                                  .countries[index]);
                        }),
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}
