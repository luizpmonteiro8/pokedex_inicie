import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemonSeries.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/screens/detail/widgets/bar_web.dart';

class DetailWeb extends StatefulWidget {
  final PokemonDetail pokemonDetail;
  final Function() closeDetail;

  const DetailWeb(
      {super.key, required this.pokemonDetail, required this.closeDetail});

  @override
  State<DetailWeb> createState() => _DetailWebState();
}

class _DetailWebState extends State<DetailWeb> {
  final PokemonService pokemonService = PokemonService();
  late List<PokemonSeries> data = [];

  @override
  void initState() {
    super.initState();

    getLifeDefenseAttackSpeed();
    // controllerSearch.addListener(_searchItem);
  }

  Future<String> getDescription() async {
    getLifeDefenseAttackSpeed();
    return await pokemonService.getDescription(widget.pokemonDetail.cod);
  }

  getLifeDefenseAttackSpeed() async {
    PokemonSeries pokemonHp;
    PokemonSeries pokemonDefense;
    PokemonSeries pokemonAttack;
    PokemonSeries pokemonSpeed;
    pokemonService
        .getLifeDefenseAttackSpeed(widget.pokemonDetail.cod)
        .then((value) => {
              pokemonHp = PokemonSeries(
                  attribute: 'Vida',
                  value: value['hp'] as int,
                  barColor:
                      charts.ColorUtil.fromDartColor(const Color(0xFFC4F789))),
              pokemonDefense = PokemonSeries(
                  attribute: 'Defesa',
                  value: value['defense'] as int,
                  barColor:
                      charts.ColorUtil.fromDartColor(const Color(0xFFF7802A))),
              pokemonAttack = PokemonSeries(
                  attribute: 'Velocidade',
                  value: value['speed'] as int,
                  barColor:
                      charts.ColorUtil.fromDartColor(const Color(0xFF49D0B0))),
              pokemonSpeed = PokemonSeries(
                  attribute: 'Ataque',
                  value: value['attack'] as int,
                  barColor:
                      charts.ColorUtil.fromDartColor(const Color(0xFFEA686D))),
              setState(() => {
                    data = [
                      pokemonHp,
                      pokemonDefense,
                      pokemonAttack,
                      pokemonSpeed
                    ]
                  })
            });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 33, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.pokemonDetail.name,
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 35,
                          fontWeight: FontWeight.w700)),
                ),
                InkWell(
                    onTap: () => widget.closeDetail(),
                    child: Text(
                      'X',
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 35,
                              fontWeight: FontWeight.w700)),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cod: ${widget.pokemonDetail.cod}',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 22,
                    ))),
                Row(
                  children: [
                    Text('Tipo:',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                        ))),
                    const SizedBox(width: 17),
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      decoration: BoxDecoration(
                        color: widget.pokemonDetail.backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          widget.pokemonDetail.type,
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width > 576 ? 200 : 100,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  backgroundImage: NetworkImage(widget.pokemonDetail.image),
                )),
            Text('Status',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700))),
            BarWeb(data: data),
            const SizedBox(
              height: 35,
            ),
            Text('Informações',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700))),
            const SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Altura:',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                ),
                Text(
                  '${widget.pokemonDetail.height}cm',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Peso:',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                ),
                Text(
                  '${widget.pokemonDetail.weight}kg',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor)),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Text('Descrição',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700))),
            const SizedBox(
              height: 7,
            ),
            FutureBuilder(
                future: getDescription(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString(),
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      )),
    ));
  }
}
