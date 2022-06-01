import 'package:flutter/material.dart';
import 'package:wishflix/Widgets/WishElement.dart';

class Book extends StatelessWidget {
  final String? image, genre, dateSortie;
  final String? name;

  const Book({Key? key, this.image, this.genre, this.dateSortie, this.name})
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

  static List<Book> getDemo() {
    List<Book> booksDemo = [
      Book(
        image: "assets/images/Kerman.png",
        name: "Les hendek",
        genre: "Policier",
        dateSortie: "Fevrier 2019",
      ),
      Book(
        image: "assets/images/Mashhad.png",
        name: "Coucou",
        genre: "Drama",
        dateSortie: "Novembre 2004",
      ),
      Book(
        image: "assets/images/Tehran.png",
        name: "Paul et ses amis",
        genre: "pas d'inspi",
        dateSortie: "Mai 2012",
      ),
    ];
    return booksDemo;
  }
}
