import 'package:uuid/uuid.dart';

// Create uuid object
const uuid = Uuid();

abstract class Base {
  Base(
      {
        this.id = 0,
        required this.image,
      required this.genre,
      required this.dateSortie,
      required this.name,
      required this.slug});

  String image, genre, dateSortie, name, slug;

  int id = uuid.v4().hashCode;

  /* factory Base.fromJson(Map<String, dynamic> json) {
    return Base(
      image: json['image'],
      genre: json['genre'],
      dateSortie: json['dateSortie'],
      name: json['name'],
    );
  } */

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['slug'] = slug;
    data['genre'] = genre;
    data['dateSortie'] = dateSortie;
    return data;
  }

  @override
  toString() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'slug': slug,
      'genre': genre,
      'dateSortie': dateSortie
    }.toString();
  }

  void goToPage(context);
}
