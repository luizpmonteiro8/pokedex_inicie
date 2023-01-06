import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:pokedex/environments.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:pokedex/screens/start/start_screen.dart';

void main() {
  EnvironmentConfig.environmentBuild = Environments.TEST;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        //remove thumb
        sliderTheme: SliderTheme.of(context).copyWith(
          trackHeight: 8.0,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
        ),
        primaryColor: const Color(0XFF2F3E77),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF2F3E77),
          secondary: const Color(0XFFEA686D),
        ),
        backgroundColor: Colors.white,
      ),
      home: kIsWeb ? const HomeScreen() : const StartScreen(),
    );
  }
}
