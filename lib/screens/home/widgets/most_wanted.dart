import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/widgets/custom_card_pokemon.dart';

class MostWanted extends StatefulWidget {
  final List mostWantedList;

  const MostWanted({super.key, required this.mostWantedList});

  @override
  State<MostWanted> createState() => _MostWantedState();
}

class _MostWantedState extends State<MostWanted> {
  int randomColorMost = 0;

  colorTypeBackGround() {
    switch (randomColorMost) {
      case 0:
        randomColorMost = 1;
        return const Color(0xFFF1AFB2);
      case 1:
        randomColorMost = 2;
        return const Color(0xFF49D0B0);
      case 2:
        randomColorMost = 3;
        return const Color(0xFF9E81A9);
      case 3:
        randomColorMost = 4;
        return const Color(0xFF2E7885);
      case 4:
        randomColorMost = 0;
        return const Color(0xFF000000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mais procurados',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor)),
        ),
        GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.mostWantedList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (widget.mostWantedList.isNotEmpty) {
                return CardPokemon(
                    name: widget.mostWantedList[index]['name'],
                    cod: widget.mostWantedList[index]['id'].toString(),
                    type: widget.mostWantedList[index]['type'],
                    backgroundColor: colorTypeBackGround(),
                    image: widget.mostWantedList[index]['image']);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
