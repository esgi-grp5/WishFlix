import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/WishElement.dart';

class Music extends StatelessWidget {
  final String? image, genre, annee, name, artist, album;

  const Music({Key? key, this.image, this.genre, this.annee, this.name, this.artist, this.album}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WishElement(
      image: image,
      titre: name,
      sousTitre: genre,
      date: annee,
    );
  }

  static List<Music> getDemo() {
    List<Music> musicsDemo = [
      Music(
        image: "assets/images/Kerman.png",
        name: "Lose yourself",
        artist: "eminem",
        genre: "Rap",
        annee: "2002",
      ),
      Music(
        image: "assets/images/Mashhad.png",
        name: "Rap god",
        artist: "eminem",
        genre: "Rap",
        annee: "2013",
      ),
      Music(
        image: "assets/images/Mashhad.png",
        name: "Corona song",
        artist: "renaud",
        genre: "Rap",
        annee: "2021",
      ),
    ];
    return musicsDemo;
  }
}
