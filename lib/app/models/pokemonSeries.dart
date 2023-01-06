import 'package:charts_flutter/flutter.dart' as charts;

class PokemonSeries {
  final String attribute;
  final int value;
  final charts.Color barColor;

  PokemonSeries(
      {required this.attribute, required this.value, required this.barColor});
}
