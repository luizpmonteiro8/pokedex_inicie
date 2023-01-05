class TypeModel {
  int? count;
  String? next;
  String? previous;
  List results;

  TypeModel({this.count, this.next, this.previous, required this.results});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
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
    return 'TypeModel: {count: $count, next: $next,previous:$previous,results:$results}';
  }
}
