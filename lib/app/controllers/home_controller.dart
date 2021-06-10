import 'package:flutter/material.dart';

import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/repositories/api_repository.dart';

class HomeController {
  final ApiRepository repository;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<ApiModel> covid = ValueNotifier(null);
  List<Countries> listaCountries = [];

  HomeController(
    this.repository,
  );

  //List<ApiModel> covidvalue = [];
  //final repository = ApiRepository();

  Future start() async {
    showLoading();
    var teste = await repository.fetchTodos();
    covid.value = teste;
    print('repo ${covid.value.global.totalConfirmed}');
    this.listaCountries = teste.countries;
    hiddenLoading();
  }

  showLoading() {
    isLoading.value = true;
    isLoading.notifyListeners();
  }

  hiddenLoading() {
    isLoading.value = false;
    isLoading.notifyListeners();
  }

  sarchCautrins(String value) {
    print(value);
    print(listaCountries[0].country);
    if (value.isNotEmpty) {
      this.covid.value.countries = listaCountries
          .where((item) =>
              item.country.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      this.covid.value.countries = listaCountries;
    }
    this.covid.notifyListeners();
  }
}
