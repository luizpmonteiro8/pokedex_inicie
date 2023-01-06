import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/widgets/custom_card_pokemon_web.dart';

class MostWantedWeb extends StatefulWidget {
  final List mostWantedList;
  final Function(PokemonDetail) setPokemonDetail;

  const MostWantedWeb(
      {super.key,
      required this.mostWantedList,
      required this.setPokemonDetail});

  @override
  State<MostWantedWeb> createState() => _MostWantedWebState();
}

class _MostWantedWebState extends State<MostWantedWeb> {
  int randomColorMost = 0;
  final itemSize = 222.0;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 50.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        Text(
          'Mais procurados',
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor)),
        ),
        const SizedBox(
          height: 50,
        ),
        Stack(
          children: [
            SizedBox(
              height: 271,
              width: MediaQuery.of(context).size.width > 576
                  ? double.infinity
                  : 212,
              child: Scrollbar(
                child: ListView.builder(
                    controller: _controller,
                    itemCount: widget.mostWantedList.length,
                    scrollDirection: Axis.horizontal,
                    itemExtent: itemSize,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (widget.mostWantedList.isNotEmpty) {
                        return SizedBox(
                          width: 222,
                          child: CardPokemonWeb(
                              name: widget.mostWantedList[index]['name'],
                              cod:
                                  widget.mostWantedList[index]['id'].toString(),
                              type: widget.mostWantedList[index]['type'],
                              height: widget.mostWantedList[index]['height']
                                  .toString(),
                              weight: widget.mostWantedList[index]['weight']
                                  .toString(),
                              backgroundColor: colorTypeBackGround(),
                              setPokemonDetail: widget.setPokemonDetail,
                              image: widget.mostWantedList[index]['image']),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            Positioned(
              top: 135,
              left: -10,
              child: ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      fixedSize: MaterialStateProperty.all(const Size(15, 15)),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary)),
                  onPressed: _moveUp,
                  child: const Icon(Icons.arrow_back_ios_new)),
            ),
            Positioned(
              top: 135,
              right: -10,
              child: ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      fixedSize: MaterialStateProperty.all(const Size(15, 15)),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary)),
                  onPressed: _moveDown,
                  child: const Icon(Icons.arrow_forward_ios)),
            )
          ],
        ),
      ],
    );
  }
}
