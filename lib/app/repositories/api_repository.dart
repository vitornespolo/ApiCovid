import 'package:dio/dio.dart';
import 'package:todo/app/models/todo_model.dart';

class ApiRepository {
  Dio dio;
  final url = 'https://api.covid19api.com/summary';

  ApiRepository([Dio client]) {
    dio = client ?? Dio();
  }

  Future<ApiModel> fetchTodos() async {
    final response = await dio.get(url);
    //final list = response.data as List;
    return ApiModel.fromJson(response.data);
  }
}
