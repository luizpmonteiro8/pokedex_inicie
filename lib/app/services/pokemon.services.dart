import 'package:dio/dio.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/environments.dart';

class PokemonService {
  final endPokemon = '/pokemon';
  final endPointDescription = '/pokemon-species';
  Dio dio = Dio();

  PokemonService() {
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.sendTimeout = 5000;
    dio.options.baseUrl = EnvironmentConfig.urlsConfig();
  }
  Future<PokemonModel> getMostWanted() async {
    Response resp;

    try {
      final response = await dio.get('$endPokemon/?limit=10');
      PokemonModel pokemonModel = PokemonModel.fromJson(response.data);
      for (var e in pokemonModel.results) {
        {
          resp = await Dio().get(e['url']);
          e['type'] = resp.data['types'][0]['type']['name'];
          e['id'] = resp.data['id'];
          e['image'] = resp.data['sprites']['other']['home']['front_default'];
        }
      }
      return pokemonModel;
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }

  Future<String> getDescription(String cod) async {
    try {
      final response = await dio.get('$endPointDescription/$cod');
      String text = response.data['flavor_text_entries'][0]['flavor_text']
          .toString()
          .replaceAll('\n', '');
      text += response.data['flavor_text_entries'][2]['flavor_text']
          .toString()
          .replaceAll('\n', '');
      return text;
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }

  Future<Map<String, Object>> getLifeDefenseAttack(String cod) async {
    try {
      final response = await dio.get('$endPokemon/$cod');

      return {
        'hp': response.data['stats'][0]['base_stat'],
        'defense': response.data['stats'][2]['base_stat'],
        'attack': response.data['stats'][1]['base_stat'],
      };
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }

  Future<PokemonModel> getPokemon() async {
    Response resp;

    try {
      final response = await dio.get(endPokemon);
      PokemonModel pokemonModel = PokemonModel.fromJson(response.data);
      for (var e in pokemonModel.results) {
        {
          resp = await Dio().get(e['url']);
          e['type'] = resp.data['types'][0]['type']['name'];
          e['id'] = resp.data['id'];
          e['image'] = resp.data['sprites']['other']['home']['front_default'];
        }
      }
      return pokemonModel;
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }

  Future<PokemonModel> getMorePokemon(String url) async {
    Response resp;

    try {
      final response = await Dio().get(url);
      PokemonModel pokemonModel = PokemonModel.fromJson(response.data);
      for (var e in pokemonModel.results) {
        {
          resp = await Dio().get(e['url']);
          e['type'] = resp.data['types'][0]['type']['name'];
          e['id'] = resp.data['id'];
          e['image'] = resp.data['sprites']['other']['home']['front_default'];
        }
      }
      return pokemonModel;
    } on DioError catch (e) {
      return Future.error('Ocorreu um erro.');
    }
  }

  getPokemonByName(String name) async {
    try {
      final response = await dio.get('$endPokemon/$name');

      response.data['type'] = response.data['types'][0]['type']['name'];
      response.data['id'] = response.data['id'];
      response.data['image'] =
          response.data['sprites']['other']['home']['front_default'];
      return {
        'name': name,
        'cod': response.data["id"],
        'image': response.data['sprites']['other']['home']['front_default'],
        'type': response.data['types'][0]['type']['name'],
      };
    } on DioError catch (e) {
      throw ('Ocorreu um erro');
    }
  }
}
