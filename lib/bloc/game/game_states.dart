import 'package:equatable/equatable.dart';
import 'package:wishflix/models/game_model.dart';

abstract class GameState extends Equatable {
  const GameState();
}

//inital game state
class InitialGameState extends GameState {
  @override
  List<Object> get props => [];
}

// game loading state
class GameListLoadingState extends GameState {
  @override
  List<Object> get props => [];
}

// gameList success state
class GameListSuccessState extends GameState {
  final List<Game> games;

  const GameListSuccessState(this.games);

  @override
  List<Object> get props => [games];
}

//gameList error state
class GameListErrorState extends GameState {
  final String error;

  const GameListErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// gameList success state
class GameSuccessState extends GameState {
  final Game game;

  const GameSuccessState(this.game);

  @override
  List<Object> get props => [game];
}
