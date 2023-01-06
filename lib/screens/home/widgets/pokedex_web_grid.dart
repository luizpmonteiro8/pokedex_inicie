import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';

import '../../../widgets/custom_card_pokemon_web.dart';

class PokedexWebGrid extends StatefulWidget {
  final Function(PokemonDetail) setPokemonDetail;

  const PokedexWebGrid({super.key, required this.setPokemonDetail});

  @override
  State<PokedexWebGrid> createState() => _PokedexWebGridState();
}

class _PokedexWebGridState extends State<PokedexWebGrid> {
  PokemonService pokemonService = PokemonService();

  int randomColorPokedex = 0;
  final itemSize = 350.0;

  //pokemon
  List pokemonList = [];
  late PokemonModel pokemonModel;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: 50.0);

    getPokemon();
    // controllerSearch.addListener(_searchItem);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  colorTypeBackGround() {
    switch (randomColorPokedex) {
      case 0:
        randomColorPokedex = 1;
        return const Color(0xFFF1AFB2);
      case 1:
        randomColorPokedex = 2;
        return const Color(0xFF49D0B0);
      case 2:
        randomColorPokedex = 3;
        return const Color(0xFF9E81A9);
      case 3:
        randomColorPokedex = 4;
        return const Color(0xFF2E7885);
      case 4:
        randomColorPokedex = 0;
        return const Color(0xFF000000);
    }
  }

  getPokemon() async {
    await pokemonService.getPokemon().then((value) => {
          setState(() {
            pokemonModel = value;
            pokemonList = value.results;
          })
        });
  }

  morePokemon() async {
    /*   await pokemonService.getMorePokemon(pokemonModel.next!).then((value) => {
          setState(() {
            pokemonModel = value;
            pokemonList.addAll(value.results);
          })
        });*/
  }

  _moveUp() {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pokédex',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor)),
            ),
            Row(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        fixedSize:
                            MaterialStateProperty.all(const Size(15, 15)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary)),
                    onPressed: _moveUp,
                    child: const Icon(Icons.arrow_back_ios_new)),
                ElevatedButton(
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        fixedSize:
                            MaterialStateProperty.all(const Size(15, 15)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary)),
                    onPressed: _moveDown,
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          height: 565,
          width: double.infinity,
          child: Scrollbar(
            child: GridView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: pokemonList.length + 1,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 222,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == pokemonList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  /* if (index == pokemonList.length - 3) {
                morePokemon();
              }*/

                  if (pokemonList.isNotEmpty) {
                    return SizedBox(
                      width: 222,
                      child: CardPokemonWeb(
                          name: pokemonList[index]['name'],
                          cod: pokemonList[index]['id'].toString(),
                          type: pokemonList[index]['type'],
                          height: pokemonList[index]['height'].toString(),
                          weight: pokemonList[index]['weight'].toString(),
                          backgroundColor: colorTypeBackGround(),
                          setPokemonDetail: widget.setPokemonDetail,
                          image: pokemonList[index]['image']),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        )
      ],
    );
  }
}
