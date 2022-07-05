import 'package:uuid/uuid.dart';

// Create uuid object
const uuid = Uuid();

class Game {
  Game(
      {required this.image,
      required this.genre,
      required this.dateSortie,
      required this.name});

  String image, genre, dateSortie, name;

  int id = uuid.v4().hashCode;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      image: json['image'],
      genre: json['genre'],
      dateSortie: json['dateSortie'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
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
      'genre': genre,
      'dateSortie': dateSortie,
    }.toString();
  }
}
