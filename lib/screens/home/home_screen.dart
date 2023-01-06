import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/app/services/type.services.dart';
import 'package:pokedex/screens/detail/detail_web.dart';
import 'package:pokedex/screens/home/widgets/appbar_mobile.dart';
import 'package:pokedex/screens/home/widgets/header_mobile.dart';
import 'package:pokedex/screens/home/widgets/header_web.dart';
import 'package:pokedex/screens/home/widgets/most_wanted_mobile.dart';
import 'package:pokedex/screens/home/widgets/most_wanted_web.dart';
import 'package:pokedex/screens/home/widgets/pokedex_mobile.dart';
import 'package:pokedex/screens/home/widgets/pokedex_web_grid.dart';
import 'package:pokedex/screens/home/widgets/pokedex_web_list.dart';
import 'package:pokedex/screens/home/widgets/type_button.dart';
import 'package:pokedex/widgets/customBottomNavigation.dart';

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

  //pokemon detail
  PokemonDetail? pokemonDetailWeb;

  //open detail screen in web version
  bool showDetail = false;

  TypeService typeService = TypeService();
  PokemonService pokemonService = PokemonService();

  final controllerSearch = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 50);

    getType();
    getPokemonMostWanted();
    _scrollController = ScrollController(initialScrollOffset: 50);
  }

  @override
  void dispose() {
    controllerSearch.dispose();
    _scrollController.dispose();
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

  setPokemonDetailWeb(PokemonDetail pokemonDetail) {
    setState(() {
      pokemonDetailWeb = pokemonDetail;
      showDetail = true;
      _scrollToTop();
    });
  }

  closeDetailWeb() {
    setState(() {
      pokemonDetailWeb = null;
      showDetail = false;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: showDetail
                ? Colors.black.withOpacity(0.3)
                : Colors.white.withOpacity(0.95),
            appBar: !kIsWeb ? AppBarMobile(appBar: AppBar()) : null,
            bottomNavigationBar:
                !kIsWeb ? const CustomBottomNavigation() : null,
            body: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  kIsWeb == true
                      ? Column(children: [
                          //web
                          HeaderWeb(
                            controllerSearch: controllerSearch,
                            setPokemonDetail: setPokemonDetailWeb,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          MostWantedWeb(
                            mostWantedList: mostWantedList,
                            setPokemonDetail: setPokemonDetailWeb,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          MediaQuery.of(context).size.width > 576
                              ? PokedexWebGrid(
                                  setPokemonDetail: setPokemonDetailWeb,
                                )
                              : PokedexWebList(
                                  firstController: _scrollController,
                                  setPokemonDetail: setPokemonDetailWeb,
                                ),
                        ])
                      : Column(children: [
                          //not web
                          HeaderMobile(
                            controllerSearch: controllerSearch,
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          TypeButton(typeList: typeList),
                          const SizedBox(
                            height: 32,
                          ),
                          MostWantedMobile(mostWantedList: mostWantedList),
                          const SizedBox(
                            height: 32,
                          ),
                          PokedexMobile(
                            firstController: _scrollController,
                          )
                        ]),
                  Offstage(
                    offstage: !showDetail,
                    child: InkWell(
                      onTap: () => closeDetailWeb(),
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1.6,
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        width: showDetail
                            ? MediaQuery.of(context).size.width > 650
                                ? 532
                                : MediaQuery.of(context).size.width * 0.99
                            : 0,
                        height: showDetail
                            ? MediaQuery.of(context).size.height * 1.6
                            : 0,
                        child: pokemonDetailWeb != null && showDetail == true
                            ? DetailWeb(
                                pokemonDetail: pokemonDetailWeb!,
                                closeDetail: closeDetailWeb,
                              )
                            : null,
                      ))
                ],
              ),
            )));
  }
}
