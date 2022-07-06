import 'package:wishflix/models/base_model.dart';

class Music extends Base {
  Music(
      {required String image,
      required String genre,
      required String dateSortie,
      required String name,
      required this.artist,
      required this.album})
      : super(image: image, genre: genre, dateSortie: dateSortie, name: name);

  String artist, album;

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      image: json['image'],
      genre: json['genre'],
      name: json['name'],
      dateSortie: json['dateSortie'],
      artist: json['artist'],
      album: json['album'],
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
