import 'package:wishflix/models/base_model.dart';

class Serie extends Base {
  Serie(
      {required String image,
      required String genre,
      required String dateSortie,
      required String name})
      : super(image: image, genre: genre, dateSortie: dateSortie, name: name);

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
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
