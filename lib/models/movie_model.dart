import 'package:wishflix/models/base_model.dart';

class Movie extends Base {
  Movie(
      {required String image,
      required String genre,
      required String dateSortie,
      required String name})
      : super(image: image, genre: genre, dateSortie: dateSortie, name: name);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      image: json['image'],
      genre: json['genre'],
      dateSortie: json['dateSortie'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return super.toMap();
  }

  @override
  toString() {
    return super.toString();
  }

  void goToPage() {
    return;
  }
}
