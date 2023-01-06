import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';

import '../../../widgets/custom_card_pokemon_web.dart';

class PokedexWebList extends StatefulWidget {
  final Function(PokemonDetail) setPokemonDetail;
  final ScrollController firstController;

  const PokedexWebList(
      {super.key,
      required this.setPokemonDetail,
      required this.firstController});

  @override
  State<PokedexWebList> createState() => _PokedexWebListState();
}

class _PokedexWebListState extends State<PokedexWebList> {
  PokemonService pokemonService = PokemonService();
  bool _isLoading = false;

  int randomColorPokedex = 0;
  final itemSize = 350.0;

  //pokemon
  List pokemonList = [];
  late PokemonModel pokemonModel;

  @override
  void initState() {
    super.initState();

    // widget.firstController.addListener(_scrollListener);
    getPokemon();
  }

  @override
  void dispose() {
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
    print('chamou');
    if (_isLoading == false) {
      /*   await pokemonService.getMorePokemon(pokemonModel.next!).then((value) => {
            setState(() {
              pokemonModel = value;
              pokemonList.addAll(value.results);
              _isLoading = false;
            })
          });*/
    }
  }

  _scrollListener() {
    var nextPageTrigger = 0.9 * widget.firstController.position.maxScrollExtent;

    if (widget.firstController.position.pixels > nextPageTrigger) {
      morePokemon();
      _isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Pokédexfff',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor)),
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          width: 306,
          child: Scrollbar(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: pokemonList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == pokemonList.length + 1) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (pokemonList.isNotEmpty) {
                    return SizedBox(
                      height: 271,
                      width: 100,
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
