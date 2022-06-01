import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/WishElement.dart';

class Serie extends StatelessWidget {
  final String? image, genre, dateSortie;
  final String? name;

  const Serie({Key? key, this.image, this.genre, this.dateSortie, this.name})
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

  static List<Serie> getDemo() {
    List<Serie> seriesDemo = [
      Serie(
        image: "assets/images/Kerman.png",
        name: "Games of throne",
        genre: "Aventure",
        dateSortie: "Fevrier 2019",
      ),
      Serie(
        image: "assets/images/Mashhad.png",
        name: "The walking dead",
        genre: "Horreur",
        dateSortie: "Février 2013",
      ),
      Serie(
        image: "assets/images/Tehran.png",
        name: "THe boys",
        genre: "SF",
        dateSortie: "Octobre 2018",
      ),
    ];
    return seriesDemo;
  }
}
