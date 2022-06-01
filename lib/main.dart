import 'package:flutter/material.dart';
import 'Notifications.dart' as prefix0;
import 'Profil.dart';
import 'SecondPage.dart';
import 'WishList.dart';
import 'HexColor.dart';
import 'Clipper08.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BottomNav(),
    theme: appTheme,
    title: "Wishlist",
  ));
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("FFA31A"),
  primaryColor: HexColor("1B1B1B"),
  /* Colors.tealAccent,*/
  secondaryHeaderColor: HexColor("1B1B1B"),
  /* Colors.teal*/
  fontFamily: 'Gotham',
);

int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), WishList(), Profil(), prefix0.Notification()];

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.home,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: "Accueil"));
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.favorite,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        label: "WishList"));
    items.add(BottomNavigationBarItem(
        backgroundColor: appTheme.primaryColor,
        activeIcon: Icon(
          Icons.person,
          color: appTheme.scaffoldBackgroundColor,
        ),
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        label: "Profil"));
    items.add(
      BottomNavigationBarItem(
          backgroundColor: appTheme.primaryColor,
          activeIcon: Icon(
            Icons.notifications,
            color: appTheme.scaffoldBackgroundColor,
          ),
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          label: "Notifications"),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodies.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.white,
          selectedItemColor: appTheme.scaffoldBackgroundColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel)
              setState(() {
                sel = index;
              });
          },
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeTop(),
            trendingMovies,
            trendingSeries,
            trendingBooks,
            trendingGames,
          ],
        ),
      ),
    );
  }
}

var selectedType = 0;
List<String> contentType = ['Films', 'Séries', 'Livres', 'Jeux', 'Tous'];

class HomeTop extends StatefulWidget {
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
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
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
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
                  'Que recherchez-vous ?',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: HexColor("ff9900"),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height! * 0.0375),
                Container(
                  width: 335,
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: c,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            child: InkWell(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SecondPage(
                                      contentTypeTemp:
                                          contentType[selectedType],
                                      searchTextTemp: c.text);
                                }));
                              },
                            ),
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: height! * 0.025,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.movie_outlined,
                          text: "Films",
                          selected: selectedType == 0),
                      onTap: () {
                        setState(() {
                          selectedType = 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.theaters,
                          text: "Séries",
                          selected: selectedType == 1),
                      onTap: () {
                        setState(() {
                          selectedType = 1;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: height! * 0.01,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Choice08(
                          icon: Icons.book,
                          text: "Livres",
                          selected: selectedType == 2),
                      onTap: () {
                        setState(() {
                          selectedType = 2;
                        });
                      },
                    ),
                    SizedBox(
                      width: width! * 0.055,
                    ),
                    InkWell(
                      child: Choice08(
                          icon: Icons.gamepad,
                          text: "Jeux",
                          selected: selectedType == 3),
                      onTap: () {
                        setState(() {
                          selectedType = 3;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;
  Choice08({this.icon, this.text, this.selected});
  @override
  _Choice08State createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: HexColor("ff9900"),
          ),
          SizedBox(
            width: width! * .020,
          ),
          Text(
            widget.text!,
            textAlign: TextAlign.left,
            style: TextStyle(color: HexColor("ff9900"), fontSize: 16),
          )
        ],
      ),
    );
  }
}

var viewallstyle =
    TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
        );

// Données essai
List<Movie> movies = [
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

List<Game> games = [
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

List<Serie> series = [
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

List<Book> books = [
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

// Widgets trending

var trendingMovies = TrendingSection(name: "Films du moment", list: movies);
var trendingGames = TrendingSection(name: "Jeux du moment", list: games);
var trendingSeries = TrendingSection(name: "Series du moment", list: series);
var trendingBooks = TrendingSection(name: "Livres du moment", list: books);

// CLASSES

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
}

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
}

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
}

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
}

class WishElement extends StatefulWidget {
  final String? image;
  final String? titre;
  final String? sousTitre;
  final String? date;

  WishElement(
      {required this.image,
      required this.titre,
      required this.sousTitre,
      required this.date});
  @override
  _WishElementState createState() => _WishElementState();
}

class _WishElementState extends State<WishElement>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                            image: AssetImage(widget.image!),
                            fit: BoxFit.fill)),
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
                            ),
                            Text(
                              widget.sousTitre!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
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
    );
  }
}

class TrendingSection extends StatefulWidget {
  final String? name;
  final List<dynamic>? list;

  TrendingSection({required this.name, required this.list});
  @override
  _TrendingSectionState createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection>
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
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("AFFICHER PLUS", style: viewallstyle)
            ],
          ),
        ),
        Container(
          height: height! * .25 < 170 ? height! * .25 : 170,
          //height: height! * .25 < 300 ? height! * .25 : 300,
          // child:
          // ConstrainedBox(
          //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
          child: ListView.builder(
              itemBuilder: (context, index) => widget.list![index],
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              itemCount: widget.list!.length,
              scrollDirection: Axis.horizontal),
        ),
      ],
    );
  }
}
