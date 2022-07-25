import 'package:flutter/material.dart';
import 'package:wishflix/models/base_model.dart';

double? width;
double? height;

class WishElement extends StatefulWidget {
  final String? image;
  final String? titre;
  final String? sousTitre;
  final String? date;
  final Base base;

  WishElement(
      {required this.image,
      required this.titre,
      required this.sousTitre,
      required this.date,
      required this.base});
  @override
  _WishElementState createState() => _WishElementState();
}

class _WishElementState extends State<WishElement>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    ImageProvider<Object> coverImageObject;
    if (widget.image != null && widget.image!.contains('assets/images')) {
      coverImageObject = AssetImage('assets/images/nodatafound_new.png');
    } else {
      coverImageObject = NetworkImage(widget.image!);
      // debugPrint('- DEBUG cover image : $coverImageObject');
    }

    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, kMovieViewRoute);
        widget.base.goToPage(context);
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: height! * .137 < 160 ? height! * .137 : 160,
                      width: width! * .5 < 250 ? width! * .5 : 250,
                      //   child: Image.asset(image,fit: BoxFit.cover,)
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: coverImageObject, fit: BoxFit.fitWidth)),
                    ),
                  ),
                  Positioned(
                    height: 60,
                    width: width! * .5 < 250 ? width! * .5 : 250,
                    left: 5,
                    //right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.black12],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                    ),
                  ),
                  Positioned(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          width: width! * 0.45 < 160 ? width! * 0.45 : 160,
                          //decoration: BoxDecoration(
                          //   shape: BoxShape.rectangle,
                          //   color: Colors.black.withOpacity(.4),
                          //  borderRadius: BorderRadius.all(Radius.circular(10))
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.titre!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                              Text(widget.sousTitre!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                    left: 10,
                    bottom: 10,
                    right: 15,
                  )
                ],
              )),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text('${(widget.date)}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic)),
            ],
          )
        ],
      ),
    );
  }
}
