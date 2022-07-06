import 'package:flutter/material.dart';
import 'package:wishflix/Screens/ViewScreens/UniversalViewScreen.dart';
import 'package:wishflix/Widgets/DisplayItem/ImageTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowInformationsWithTitle.dart';
import 'package:wishflix/Widgets/DisplayItem/RowWishListInfo.dart';
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

  @override
  void goToPage(context) {
    List<Widget> screenBody = [];

    screenBody.add(ImageTitle(
        title: this.name,
        subTitle1: "2h23",
        subTitle2: this.genre,
        imageAssetUrl: this.image));
    screenBody
        .add(RowWishListInfo(dateSortie: this.dateSortie, estVuText: "Non vu"));
    screenBody.add(RowInformationsWithTitle(
      informationTitle: "Synopsis",
      informationContent:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac facilisis ligula, sit amet lacinia erat. Suspendisse vel sagittis elit. Praesent suscipit nisl sit amet eros feugiat finibus. Nullam suscipit enim eleifend lorem rutrum, vel tempor enim faucibus. Vestibulum vitae facilisis lacus, eu ultrices felis. In scelerisque risus vitae justo convallis cursus. Maecenas ultrices eget tellus nec fermentum. Donec porttitor, leo sagittis aliquet efficitur, urna libero aliquam nibh, ut egestas justo lorem vitae nisi. Integer sed ornare lorem. Integer ornare augue eget erat aliquam hendrerit. Nulla consequat enim sit amet risus gravida, nec rutrum libero tincidunt. Ut non massa sed enim dictum volutpat. In diam justo, convallis vitae commodo vitae, pulvinar at nisl. Fusce ultricies non dolor at malesuada. \n Etiam gravida eleifend interdum. Integer et finibus mauris. Curabitur dapibus lacinia tincidunt. Nam ut quam at eros ultrices sodales. Suspendisse pellentesque ullamcorper pulvinar. Sed sed nisl enim. Pellentesque placerat ullamcorper velit sed tempus. Proin dictum volutpat fermentum. Aliquam erat volutpat. Suspendisse sollicitudin, tellus id luctus consectetur, est nulla iaculis ex, condimentum euismod dolor nulla sit amet lacus. Praesent placerat non velit ut dignissim. Maecenas porttitor sollicitudin turpis. Integer finibus eros eget velit aliquet, et consequat sapien posuere.",
    ));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UniversalViewScreen(
        screenBody: screenBody,
      );
    }));
  }
}
