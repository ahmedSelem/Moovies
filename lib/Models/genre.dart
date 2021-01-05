class Genres {
  final String name;
  final int id;

  Genres.formJson(dynamic json)
      : this.name = json['name'],
        this.id = json['id'];
}
