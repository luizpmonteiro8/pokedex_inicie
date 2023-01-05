class PokemonModel {
  int? count;
  String? next;
  String? previous;
  List results;

  PokemonModel({this.count, this.next, this.previous, required this.results});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results']);
  }

  Map toJson() {
    {
      return {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results
      };
    }
  }

  @override
  String toString() {
    return 'PokemonModel: {count: $count, next: $next,previous:$previous,results:$results}';
  }
}
