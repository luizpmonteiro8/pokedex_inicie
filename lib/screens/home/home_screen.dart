import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/app/services/type.services.dart';
import 'package:pokedex/screens/home/widgets/header_web.dart';
import 'package:pokedex/screens/home/widgets/most_wanted.dart';
import 'package:pokedex/screens/home/widgets/pokedex.dart';
import 'package:pokedex/screens/home/widgets/type_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //type
  List typeList = [];
  //mostwanted
  List mostWantedList = [];
  //pokemon
  List pokemonList = [];
  late PokemonModel pokemonModel;

  TypeService typeService = TypeService();
  PokemonService pokemonService = PokemonService();

  final controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();

    getType();
    getPokemonMostWanted();
    // controllerSearch.addListener(_searchItem);
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  getType() async {
    return await typeService.getType().then((value) => {
          setState(() {
            typeList = value.results;
          })
        });
  }

  getPokemonMostWanted() async {
    pokemonService.getMostWanted().then((value) => {
          setState(() {
            mostWantedList = value.results;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            HeaderWeb(
              controllerSearch: controllerSearch,
            ),
            const SizedBox(
              height: 20,
            ),
            TypeButton(
              typeList: typeList,
            ),
            const SizedBox(
              height: 32,
            ),
            MostWanted(mostWantedList: mostWantedList),
            const SizedBox(
              height: 32,
            ),
            const Pokedex(),
          ],
        ),
      ),
    ));
  }
}
