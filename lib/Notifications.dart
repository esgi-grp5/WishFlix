import 'package:flutter/material.dart';
import 'HexColor.dart';
import 'Clipper08.dart';

double? width;
double? height;

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      // backgroundColor: HexColor("1B1B1B"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            NotificationsTop(),
            oldNotificationListWidget,
          ],
        ),
      ),
    );
  }
}

var viewallstyle =
    TextStyle(fontSize: 14, color: HexColor("1B1B1B") //Colors.teal
        );

class NotificationsTop extends StatefulWidget {
  @override
  _NotificationTop createState() => _NotificationTop();
}

class _NotificationTop extends State<NotificationsTop> {
  TextEditingController c = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor("1B1B1B"), HexColor("1B1B1B")])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height! / 16,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height! / 16,
                ),
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                newNotificationListWidget
              ],
            ),
          ),
        )
      ],
    );
  }
}

List<NotificationElement> newNotifications = [
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 9 saison 8 sorti le 07/11/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("FFA31A"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 8 saison 8 sorti le 07/11/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("FFA31A"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 7 saison 8 sorti le 31/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("FFA31A"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 6 saison 8 sorti le 25/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("FFA31A"),
  ),
];
List<NotificationElement> oldNotifications = [
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 5 saison 8 sorti le 25/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("1B1B1B"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 4 saison 8 sorti le 25/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("1B1B1B"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 3 saison 8 sorti le 18/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("1B1B1B"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 2 saison 8 sorti le 11/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("1B1B1B"),
  ),
  NotificationElement(
    titre: "Nouveau épisode",
    sousTitre: "Game of thrones",
    description: "Episode 1 saison 8 sorti le 05/10/2019",
    idEpisode: "idEpisode",
    backgroundColor: HexColor("1B1B1B"),
  ),
];

var newNotificationListWidget = NotificationSection(
    name: "NEW", list: newNotifications, hauteur: 74, textColor: Colors.white);
var oldNotificationListWidget = NotificationSection(
    name: "OLD",
    list: oldNotifications,
    hauteur: 80,
    textColor: HexColor("1B1B1B"));

class NotificationSection extends StatefulWidget {
  final String? name;
  final List<dynamic>? list;
  final int? hauteur;
  final Color textColor;

  NotificationSection(
      {required this.name,
      required this.list,
      required this.hauteur,
      required this.textColor});
  @override
  _NotificationSectionState createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(
              //   width: width! * 0.05,
              // ),
              Text(
                widget.name!,
                style: TextStyle(color: widget.textColor, fontSize: 16),
              ),
              Spacer(),
              Text("MARQUER COMME LU",
                  style: TextStyle(fontSize: 14, color: widget.textColor))
            ],
          ),
        ),
        Container(
          height: height! * (1 - widget.hauteur! / 100),
          //height: height! * .25 < 300 ? height! * .25 : 300,
          // child:
          // ConstrainedBox(
          //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
          child: ListView.builder(
              itemBuilder: (context, index) => widget.list![index],
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemCount: widget.list!.length,
              scrollDirection: Axis.vertical),
        ),
      ],
    );
  }
}

class NotificationElement extends StatefulWidget {
  final String? titre;
  final String? sousTitre;
  final String? description;
  final String? idEpisode;
  final Color backgroundColor;

  NotificationElement(
      {required this.titre,
      required this.sousTitre,
      required this.description,
      required this.idEpisode,
      required this.backgroundColor});
  @override
  _NotifElementState createState() => _NotifElementState();
}

class _NotifElementState extends State<NotificationElement>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              color: widget.backgroundColor,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: height! * .2 < 70 ? height! * .2 : 70,
                      width: width! - 20,
                      //   child: Image.asset(image,fit: BoxFit.cover,)
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    bottom: 10,
                    right: 15,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     color: Colors.black.withOpacity(.4),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.titre!,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.sousTitre!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.description!,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
