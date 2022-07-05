import 'package:equatable/equatable.dart';
import 'package:wishflix/models/game_model.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

//add game event
class AddGameEvent extends GameEvent {
  final Game game;

  const AddGameEvent({required this.game});

  @override
  List<Object> get props => [Game];
}

// remove game event
class RemoveGameEvent extends GameEvent {
  final int gameId;

  const RemoveGameEvent({required this.gameId});

  @override
  List<Object> get props => [gameId];
}

//get all games event
class GetAllGamesEvent extends GameEvent {
  @override
  List<Object> get props => [];
}
