import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/Widgets/WishElement.dart';
import 'package:wishflix/bloc/export_bloc.dart';
import 'package:wishflix/Screens/main.dart' as rootPage;

double? width;
double? height;

class ListViewWishEl extends StatefulWidget {
  final String? typeElements;

  ListViewWishEl({required this.typeElements});
  @override
  _ListViewWishElState createState() => _ListViewWishElState();
}

class _ListViewWishElState extends State<ListViewWishEl>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.longestSide;
    BlocBuilder? bloc;
    switch (widget.typeElements) {
      case "Musics":
        bloc = BlocBuilder<MusicBloc, MusicState>(
          buildWhen: (previous, current) => previous is MusicListLoadingState,
          builder: (context, state) {
            if (state is MusicListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.musics
                    .map(
                      (music) => WishElement(
                        image: music.image,
                        titre: music.name,
                        sousTitre: music.artist,
                        date: music.dateSortie,
                      ),
                    )
                    .toList(),
              );
            }
            if (state is MusicListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MusicListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;

      case "Series":
        bloc = BlocBuilder<SerieBloc, SerieState>(
          buildWhen: (previous, current) => previous is SerieListLoadingState,
          builder: (context, state) {
            if (state is SerieListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.series
                    .map(
                      (serie) => WishElement(
                        image: serie.image,
                        titre: serie.name,
                        sousTitre: serie.genre,
                        date: serie.dateSortie,
                      ),
                    )
                    .toList(),
              );
            }
            if (state is SerieListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SerieListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;
      case "Games":
        bloc = BlocBuilder<GameBloc, GameState>(
          buildWhen: (previous, current) => previous is GameListLoadingState,
          builder: (context, state) {
            if (state is GameListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.games
                    .map(
                      (game) => WishElement(
                        image: game.image,
                        titre: game.name,
                        sousTitre: game.genre,
                        date: game.dateSortie,
                      ),
                    )
                    .toList(),
              );
            }
            if (state is GameListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GameListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;
      case "Movies":
        bloc = BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) => previous is MovieListLoadingState,
          builder: (context, state) {
            if (state is MovieListSuccessState) {
              return ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.movies
                    .map(
                      (movie) => WishElement(
                        image: movie.image,
                        titre: movie.name,
                        sousTitre: movie.genre,
                        date: movie.dateSortie,
                      ),
                    )
                    .toList(),
              );
            }
            if (state is MovieListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MovieListErrorState) {
              return Center(child: Text(state.error));
            }
            return Container();
          },
        );
        break;
      default:
        break;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Vos jeux",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              Text("AFFICHER PLUS",
                  style: TextStyle(
                      fontSize: 14, color: rootPage.appTheme.primaryColor))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
              height: height! * .25 < 170 ? height! * .25 : 170,
              //height: height! * .25 < 300 ? height! * .25 : 300,
              // child:
              // ConstrainedBox(
              //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
              child: bloc),
        ),
      ],
    );
  }
}
