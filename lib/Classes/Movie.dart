import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/WishElement.dart';

class Movie extends StatelessWidget {
  final String? image, genre, dateSortie;
  final String? name;

  const Movie({Key? key, this.image, this.genre, this.dateSortie, this.name})
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

  static List<Movie> getDemo() {
    List<Movie> moviesDemo = [
      Movie(
        image: "assets/images/Kerman.png",
        name: "Taken",
        genre: "Action",
        dateSortie: "Avril 2005",
      ),
      Movie(
        image: "assets/images/Mashhad.png",
        name: "Harry potter",
        genre: "Fantastique",
        dateSortie: "Aout 2002",
      ),
      Movie(
        image: "assets/images/Tehran.png",
        name: "Avengers",
        genre: "SF",
        dateSortie: "Septembre 2019",
      ),
    ];
    return moviesDemo;
  }
}
