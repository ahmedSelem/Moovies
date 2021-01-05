class Movies {
  final String title, backgroundPosterUrl, posterUrl;
  final double rate;
  final int id;
  Movies.fromJson(dynamic json)
      : this.title = json['title'],
       this.id = json['id'],
      this.rate = json['vote_average'].toDouble(),
        this.backgroundPosterUrl = 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}',
        this.posterUrl = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
}
