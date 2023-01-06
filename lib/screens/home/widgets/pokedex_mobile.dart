import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/widgets/custom_card_pokemon_mobile.dart';

class PokedexMobile extends StatefulWidget {
  final ScrollController firstController;

  const PokedexMobile({
    super.key,
    required this.firstController,
  });

  @override
  State<PokedexMobile> createState() => _PokedexMobileState();
}

class _PokedexMobileState extends State<PokedexMobile> {
  PokemonService pokemonService = PokemonService();

  int randomColorPokedex = 0;
  bool _isLoading = false;

  //pokemon
  List pokemonList = [];
  PokemonModel pokemonModel = PokemonModel(results: []);

  @override
  void initState() {
    super.initState();

    getPokemon();

    widget.firstController.addListener(_scrollListener);
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
            //prevent error
            _isLoading = false;
          })
        });
  }

  morePokemon() async {
    if (_isLoading == false) {
      await pokemonService.getMorePokemon(pokemonModel.next!).then((value) => {
            setState(() {
              pokemonModel = value;
              pokemonList.addAll(value.results);
              _isLoading = false;
            })
          });
    }
  }

  _scrollListener() {
    var nextPageTrigger = 0.9 * widget.firstController.position.maxScrollExtent;

    if (widget.firstController.position.pixels > nextPageTrigger &&
        pokemonModel.next != null) {
      morePokemon();
      _isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pokédex',
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor)),
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: pokemonModel?.next == null
                  ? pokemonList.length
                  : pokemonList.length + 1,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 160,
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == pokemonList.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (pokemonList.isNotEmpty) {
                  return CardPokemonMobile(
                      name: pokemonList[index]['name'],
                      cod: pokemonList[index]['id'].toString(),
                      type: pokemonList[index]['type'],
                      backgroundColor: colorTypeBackGround(),
                      image: pokemonList[index]['image']);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
