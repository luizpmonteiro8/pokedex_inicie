import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/services/pokemon.services.dart';
import 'package:pokedex/screens/detail/widgets/appbar_mobile.dart';
import 'package:pokedex/widgets/customBottomNavigation.dart';

class DetailMobile extends StatelessWidget {
  final PokemonService pokemonService = PokemonService();

  final String name;
  final String cod;
  final String type;
  final String image;
  final Color backgroundColor;

  DetailMobile({
    super.key,
    required this.name,
    required this.cod,
    required this.type,
    required this.image,
    required this.backgroundColor,
  });

  Future<String> getDescription() async {
    return await pokemonService.getDescription(cod);
  }

  Future<Map<String, Object>> getLifeDefenseAttackSpeed() async {
    return await pokemonService.getLifeDefenseAttackSpeed(cod);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBarMobile(appBar: AppBar()),
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFF1B0B3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.topCenter,
              child: Image.network(
                image,
                fit: BoxFit.contain,
              )),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Text('Cod: $cod',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ))),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                          Icon(
                            Icons.share_outlined,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 80,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            type,
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
              const SizedBox(
                height: 17,
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
                height: 15,
              ),
              FutureBuilder<Map<String, Object>>(
                  future: getLifeDefenseAttackSpeed(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text('Vida',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600))),
                              const SizedBox(width: 63),
                              Slider(
                                value: (snapshot.data!['hp'] as int).toDouble(),
                                max: 250,
                                divisions: null,
                                label: '',
                                onChanged: (f) {},
                                activeColor: const Color(0xFFF7802A),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Defesa',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600))),
                              const SizedBox(width: 50),
                              Slider(
                                value: (snapshot.data!['defense'] as int)
                                    .toDouble(),
                                max: 250,
                                divisions: null,
                                label: '',
                                onChanged: (f) {},
                                activeColor: const Color(0xFFC4F789),
                                inactiveColor: Colors.black12,
                                thumbColor: Colors.black,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Ataque',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600))),
                              const SizedBox(width: 50),
                              Slider(
                                value: (snapshot.data!['attack'] as int)
                                    .toDouble(),
                                max: 250,
                                divisions: null,
                                label: '',
                                onChanged: (f) {},
                                activeColor: const Color(0xFFEA686D),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ]),
          )
        ],
      )),
    ));
  }
}
