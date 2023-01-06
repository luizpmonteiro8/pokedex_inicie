import 'dart:ui';

class PokemonDetail {
  String name;
  String cod;
  String type;
  String height;
  String weight;
  String image;
  Color backgroundColor;

  PokemonDetail(
      {required this.name,
      required this.cod,
      required this.type,
      required this.height,
      required this.weight,
      required this.image,
      required this.backgroundColor});

  @override
  String toString() {
    return 'PokemonDetail: {name: $name, cod: $cod,type:$type,height:$height,weight:$weight,image:$image,backgroundColor:$backgroundColor}';
  }
}
