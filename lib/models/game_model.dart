import 'package:uuid/uuid.dart';

// Create uuid object
const uuid = Uuid();

class Game {
  Game(
      {required this.image,
      required this.genre,
      required this.annee,
      required this.name,
      required this.artist,
      required this.album});

  String image, genre, annee, name, artist, album;

  int id = uuid.v4().hashCode;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      image: json['image'],
      genre: json['genre'],
      annee: json['annee'],
      name: json['name'],
      artist: json['artist'],
      album: json['album'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['genre'] = genre;
    data['annee'] = annee;
    data['artist'] = artist;
    data['album'] = album;
    return data;
  }

  @override
  toString() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'genre': genre,
      'annee': annee,
      'artist': artist,
      'album': album,
    }.toString();
  }
}
