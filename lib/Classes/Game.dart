import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/WishElement.dart';

class Game extends StatelessWidget {
  final String? image, genre, dateSortie;
  final String? name;

  const Game({Key? key, this.image, this.genre, this.dateSortie, this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WishElement(
      image: image,
      titre: name,
      sousTitre: genre,
      date: dateSortie,
    );
  }

  static List<Game> getDemo() {
    List<Game> gamesDemo = [
      Game(
        image: "assets/images/Kerman.png",
        name: "Call of duty",
        genre: "Action",
        dateSortie: "Fevrier 2019",
      ),
      Game(
        image: "assets/images/Mashhad.png",
        name: "World of warcraft",
        genre: "MMORPG",
        dateSortie: "Novembre 2004",
      ),
      Game(
        image: "assets/images/Tehran.png",
        name: "Diablo 3",
        genre: "Hack and slash",
        dateSortie: "Mai 2012",
      ),
    ];

    return gamesDemo;
  }
}
