import 'dart:math';

import 'package:wishflix/Screens/main.dart' as rootPage;

import 'package:flutter/material.dart';
import 'package:wishflix/Screens/ViewScreens/UniversalViewScreen.dart';
import 'package:wishflix/Widgets/DisplayItem/ImageTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RateSection.dart';
import 'package:wishflix/Widgets/DisplayItem/RowInformationsWithTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowTimesWishlisted.dart';
import 'package:wishflix/Widgets/DisplayItem/RowWishListInfo.dart';
import 'package:wishflix/models/base_model.dart';

class Music extends Base {
  Music(
      {required String image,
      required String genre,
      required String dateSortie,
      required String name,
      required String slug,
      required int id,
      required this.artist,
      required this.album})
      : super(
            image: image,
            genre: genre,
            dateSortie: dateSortie,
            name: name,
            slug: slug,
            id: id);

  String artist, album;

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      image: json['image'],
      genre: json['genre'],
      slug: json['slug'],
      name: json['name'],
      dateSortie: json['dateSortie'],
      artist: json['artist'],
      album: json['album'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toMap();
    data['artist'] = artist;
    data['album'] = album;
    return data;
  }

  @override
  toString() {
    return super.toString();
  }

  @override
  void goToPage(context) {
    List<Widget> screenBody = [];

    screenBody.add(ImageTitle(
        title: this.name,
        subTitle1: this.artist,
        subTitle2: this.genre,
        imageAssetUrl: this.image));
    screenBody.add(
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: rootPage.appTheme.backgroundColor,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
    screenBody
        .add(RowWishListInfo(dateSortie: this.dateSortie, estVuText: "Non vu"));
    screenBody.add(RowInformationsWithTitle(
        informationTitle: "Paroles",
        informationContent: 'Lorem ipsum dolor sit amet\n'
            'Nullam ac facilisis ligula\n'
            'sit amet lacinia erat. \n'
            'Suspendisse vel sagittis elit.\n'
            'Rraesent suscipit nisl sit \n'
            'amet eros feugiat finibus.\n'
            'Nullam suscipit enim eleifend\n'
            'lorem rutrum, vel tempor enim \n'
            'faucibus. Vestibulum vitae facilisis\n'
            'lacus, eu ultrices felis.\n'
            'In scelerisque risus vitae \n'
            'justo convallis cursus. Maecenas \n'
            'ultrices eget tellus nec fermentum. \n'
            'Donec porttitor, leo sagittis aliquet \n'
            'efficitur, urna libero aliquam nibh, \n'
            'ut egestas justo lorem vitae nisi. \n'
            'Integer sed ornare lorem. Integer\n'));

    screenBody.add(RowTimesWishlisted(
        informationTitle: this.name, informationTimesAdded: 12));
    Random random = new Random();
    double randomNumber = random.nextInt(6).toDouble();
    screenBody.add(RateSection(
      starNumber: randomNumber,
    ));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UniversalViewScreen(
        screenTitle: "Musique",
        screenBody: screenBody,
      );
    }));
  }
}
