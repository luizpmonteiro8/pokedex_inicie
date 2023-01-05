import 'package:dio/dio.dart';
import 'package:pokedex/app/models/type.dart';
import 'package:pokedex/environments.dart';

class TypeService {
  final endPoint = '/type';
  Dio dio = Dio();

  TypeService() {
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.sendTimeout = 5000;
    dio.options.baseUrl = EnvironmentConfig.urlsConfig();
  }
  Future<TypeModel> getType() async {
    try {
      final response = await dio.get('$endPoint');
      return TypeModel.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }
}
