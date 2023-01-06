import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';

class HeaderWeb extends StatelessWidget {
  final Function(PokemonDetail) setPokemonDetail;

  final TextEditingController controllerSearch;
  final PokemonService pokemonService = PokemonService();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  HeaderWeb(
      {super.key,
      required this.controllerSearch,
      required this.setPokemonDetail});

  getPokemonByName(BuildContext context) {
    pokemonService
        .getPokemonByName(controllerSearch.text)
        .then((value) => {
              print(value),
              setPokemonDetail(PokemonDetail(
                  name: capitalize(value['name']),
                  cod: value['cod'].toString(),
                  type: value['type'],
                  height: value['height'].toString(),
                  weight: value['weight'].toString(),
                  image: value['image'],
                  backgroundColor: Colors.black))
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
    return Row(
      mainAxisAlignment: MediaQuery.of(context).size.width > 768
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width > 768 ? 150 : 305,
                minHeight: MediaQuery.of(context).size.width > 768 ? 150 : 297,
              ),
              child: Image(
                image: MediaQuery.of(context).size.width > 768
                    ? const AssetImage('graphics/inicie.png')
                    : const AssetImage('graphics/pokemon_logo.png'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              constraints: const BoxConstraints(maxWidth: 500, maxHeight: 464),
              child: RichText(
                  text: TextSpan(
                      text: 'Explore o mundo dos ',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: MediaQuery.of(context).size.width > 768
                                  ? 55
                                  : 35,
                              fontWeight: FontWeight.w700,
                              shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4),
                          ])),
                      children: [
                    TextSpan(
                        text: 'Pokémons',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize:
                                    MediaQuery.of(context).size.width > 768
                                        ? 55
                                        : 35,
                                fontWeight: FontWeight.w700)))
                  ])),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.2,
                constraints:
                    const BoxConstraints(maxWidth: 500, maxHeight: 464),
                child: Text(
                  'Descubra todas as espécies de Pokémons',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 768 ? 25 : 16,
                          color: Theme.of(context).primaryColor)),
                )),
            const SizedBox(
              height: 30,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.3,
                constraints: const BoxConstraints(maxWidth: 350),
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
                        child: const Text('Buscar'),
                      ),
                    ))),
          ],
        ),
        Offstage(
          offstage: MediaQuery.of(context).size.width > 768 ? false : true,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                constraints:
                    const BoxConstraints(maxWidth: 517, maxHeight: 464),
                child: const Image(
                  fit: BoxFit.contain,
                  image: AssetImage('graphics/pokemon_front_web.png'),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
