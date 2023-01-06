import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemonSeries.dart';

class BarWeb extends StatelessWidget {
  final List<PokemonSeries> data;
  const BarWeb({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PokemonSeries, String>> series = [
      charts.Series(
          id: "PokemonSeries",
          data: data,
          domainFn: (PokemonSeries series, _) => series.attribute,
          measureFn: (PokemonSeries series, _) => series.value,
          colorFn: (PokemonSeries series, _) => series.barColor)
    ];

    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: charts.BarChart(
        series,
        animate: false,
        domainAxis: charts.OrdinalAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
              fontSize: 12, // size in Pts.
              color: charts.ColorUtil.fromDartColor(const Color(0xFFA2A9B0))),
        )),
        defaultRenderer: charts.BarRendererConfig(
          maxBarWidthPx: 31,
        ),
      ),
    );
  }
}
