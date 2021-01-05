class Persons {
  final int id;
  final String posterPath, name;
  Persons.formJson(dynamic json)
      : this.id = json['id'],
        this.name = json['name'],
        this.posterPath =
            'https://image.tmdb.org/t/p/original/${json['profile_path']}';
}
