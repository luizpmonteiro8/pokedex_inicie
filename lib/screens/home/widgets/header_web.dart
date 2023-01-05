import 'package:flutter/material.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/screens/detail/detail.dart';

class HeaderWeb extends StatelessWidget {
  final TextEditingController controllerSearch;
  final PokemonService pokemonService = PokemonService();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  HeaderWeb({super.key, required this.controllerSearch});

  getPokemonByName(BuildContext context) {
    pokemonService
        .getPokemonByName(controllerSearch.text)
        .then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            name: capitalize(value['name'].toString()),
                            cod: value['cod'].toString(),
                            image: value['image'].toString(),
                            type: value['type'].toString(),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          )))
            })
        .catchError((e) => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'Pokémon não encontrado!',
                  style: TextStyle(fontSize: 25),
                ),
              ))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [],
      ),
    );
  }
}
