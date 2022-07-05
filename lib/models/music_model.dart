import 'package:uuid/uuid.dart';

// Create uuid object
const uuid = Uuid();

class Music {
  Music(
      {required this.image,
      required this.genre,
      required this.artist,
      required this.annee,
      required this.name});

  String image, genre, name, artist, annee;

  int id = uuid.v4().hashCode;

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      image: json['image'],
      genre: json['genre'],
      name: json['name'],
      artist: json['artist'],
      annee: json['annee'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['genre'] = genre;
    data['artist'] = artist;
    data['annee'] = annee;
    return data;
  }

  @override
  toString() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'genre': genre,
      'artist': artist,
      'annee': annee,
    }.toString();
  }
}
