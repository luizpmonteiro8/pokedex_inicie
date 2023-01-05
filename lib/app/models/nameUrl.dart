class NameUrl {
  String name;
  String url;

  NameUrl({required this.name, required this.url});

  factory NameUrl.fromJson(Map<String, dynamic> json) {
    return NameUrl(
      name: json['name'],
      url: json['url'],
    );
  }

  Map toJson() {
    return {'name': name, 'url': url};
  }

  @override
  String toString() {
    return 'NameUrlObject: {name: $name, url: $url}';
  }
}
