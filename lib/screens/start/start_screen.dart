import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/screens/home/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Scrollbar(
        child: Column(children: [
          const Image(
            image: AssetImage('graphics/pokemon_logo.png'),
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Explore o mundo \n dos ',
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4),
                      ])),
                  children: [
                    TextSpan(
                        text: 'Pokémons',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 35,
                                fontWeight: FontWeight.w700)))
                  ])),
          Text(
            'Descubra todas as espécies de Pokémons',
            style: GoogleFonts.nunito(
                textStyle: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor)),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  maximumSize: const Size(226, 43),
                  minimumSize: const Size(226, 43)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Começar',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )),
                  const Icon(Icons.arrow_forward_ios)
                ],
              )),
        ]),
      ),
    )));
  }
}
