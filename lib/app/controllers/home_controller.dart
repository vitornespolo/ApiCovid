import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/repositories/api_repository.dart';

class HomeController {
  final ApiRepository repository;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<ApiModel> covid = ValueNotifier(null);

  HomeController(this.repository);

  //List<ApiModel> covidvalue = [];
  //final repository = ApiRepository();


  Future start() async {
    toggleLoading();
    //final teste = await repository.fetchTodos();
    covid.value = await repository.fetchTodos();
    print('repo ${covid.value.global.totalConfirmed}');
    toggleLoading();
  }

  toggleLoading() {
    isLoading.value = !isLoading.value;
    //isLoading.notifyListeners();
  }
}
