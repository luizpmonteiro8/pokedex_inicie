import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';

class CardPokemonWeb extends StatefulWidget {
  final String name;
  final String cod;
  final String type;
  final String height;
  final String weight;
  final String image;
  final Color backgroundColor;
  final Function(PokemonDetail) setPokemonDetail;

  const CardPokemonWeb({
    super.key,
    required this.name,
    required this.cod,
    required this.height,
    required this.weight,
    required this.image,
    required this.type,
    required this.setPokemonDetail,
    required this.backgroundColor,
  });

  @override
  State<CardPokemonWeb> createState() => _CardPokemonWebState();
}

class _CardPokemonWebState extends State<CardPokemonWeb> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.setPokemonDetail(PokemonDetail(
              name: capitalize(widget.name),
              cod: widget.cod,
              type: widget.type,
              height: widget.height,
              weight: widget.weight,
              image: widget.image,
              backgroundColor: widget.backgroundColor));
        },
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    capitalize(widget.name),
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                  ),
                  Text(
                    widget.cod,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('graphics/background_poke.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                ),
              )),
              const SizedBox(
                height: 4,
              ),
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
                    '${widget.height}cm',
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
                    '${widget.weight}kg',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
