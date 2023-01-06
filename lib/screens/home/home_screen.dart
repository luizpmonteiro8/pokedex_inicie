import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/app/services/type.services.dart';
import 'package:pokedex/screens/detail/detail_web.dart';
import 'package:pokedex/screens/home/widgets/header_mobile.dart';
import 'package:pokedex/screens/home/widgets/header_web.dart';
import 'package:pokedex/screens/home/widgets/most_wanted_mobile.dart';
import 'package:pokedex/screens/home/widgets/most_wanted_web.dart';
import 'package:pokedex/screens/home/widgets/pokedex_mobile.dart';
import 'package:pokedex/screens/home/widgets/pokedex_web_grid.dart';
import 'package:pokedex/screens/home/widgets/pokedex_web_list.dart';
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

  //pokemon detail
  PokemonDetail? pokemonDetailWeb;
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
    // controllerSearch.addListener(_searchItem);
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
      backgroundColor:
          showDetail ? Colors.black.withOpacity(0.3) : Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: MediaQuery.of(context).size.width > 576
            ? const EdgeInsets.only(left: 60, right: 60, top: 15, bottom: 98)
            : const EdgeInsets.only(left: 32, right: 0, top: 10, bottom: 98),
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Column(
              children: [
                Offstage(
                    offstage: !kIsWeb,
                    child: HeaderWeb(
                      controllerSearch: controllerSearch,
                      setPokemonDetail: setPokemonDetailWeb,
                    )),
                Offstage(
                    offstage: kIsWeb,
                    child: HeaderMobile(
                      controllerSearch: controllerSearch,
                    )),
                Offstage(
                    offstage: kIsWeb,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TypeButton(
                          typeList: typeList,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 32,
                ),
                Offstage(
                  offstage: !kIsWeb,
                  child: MostWantedWeb(
                    mostWantedList: mostWantedList,
                    setPokemonDetail: setPokemonDetailWeb,
                  ),
                ),
                Offstage(
                  offstage: kIsWeb,
                  child: MostWantedMobile(mostWantedList: mostWantedList),
                ),
                const SizedBox(
                  height: 32,
                ),
                Offstage(
                  offstage: !kIsWeb,
                  child: MediaQuery.of(context).size.width > 576
                      ? PokedexWebGrid(
                          setPokemonDetail: setPokemonDetailWeb,
                        )
                      : PokedexWebList(
                          firstController: _scrollController,
                          setPokemonDetail: setPokemonDetailWeb,
                        ),
                ),
                const Offstage(
                  offstage: kIsWeb,
                  child: PokedexMobile(),
                ),
              ],
            ),
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
                      ? MediaQuery.of(context).size.width > 576
                          ? 532
                          : 320
                      : 0,
                  height:
                      showDetail ? MediaQuery.of(context).size.height * 1.6 : 0,
                  child: pokemonDetailWeb != null && showDetail == true
                      ? DetailWeb(
                          pokemonDetail: pokemonDetailWeb!,
                          closeDetail: closeDetailWeb,
                        )
                      : null,
                ))
          ],
        ),
      ),
    ));
  }
}
