import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/detail/detail_mobile.dart';
import 'package:pokedex/widgets/custom_button_type.dart';

class CardPokemonMobile extends StatefulWidget {
  final String name;
  final String cod;
  final String type;
  final String image;
  final Color backgroundColor;

  const CardPokemonMobile({
    super.key,
    required this.name,
    required this.cod,
    required this.type,
    required this.image,
    required this.backgroundColor,
  });

  @override
  State<CardPokemonMobile> createState() => _CardPokemonMobileState();
}

class _CardPokemonMobileState extends State<CardPokemonMobile> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailMobile(
                        name: capitalize(widget.name),
                        cod: widget.cod,
                        image: widget.image,
                        type: widget.type,
                        backgroundColor: widget.backgroundColor,
                      )));
        },
        child: Card(
            child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    capitalize(widget.name),
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ButtonType(name: widget.type, color: widget.backgroundColor),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.cod,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Theme.of(context).primaryColor)),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                height: double.infinity,
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
            ],
          ),
        )));
  }
}
