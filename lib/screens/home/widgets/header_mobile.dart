import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/screens/detail/detail.dart';

class HeaderMobile extends StatelessWidget {
  final TextEditingController controllerSearch;
  final PokemonService pokemonService = PokemonService();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  HeaderMobile({super.key, required this.controllerSearch});

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
      width: double.infinity,
      height: 152,
      decoration: BoxDecoration(
        color: const Color(0xFFF1B0B3).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 27),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    'Pokedéx',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      'Todas as espécies de pokémons estão esperando por você!',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                      ))),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 200,
                      height: 31,
                      child: TextField(
                          controller: controllerSearch,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.secondary)),
                              onPressed: () => getPokemonByName(context),
                              child: const Icon(Icons.search),
                            ),
                          ))),
                ])),
            const Image(
              image: AssetImage('graphics/pikachu_sit.png'),
            ),
          ],
        ),
      ),
    );
  }
}
