import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/bloc/game/game_events.dart';
import 'package:wishflix/bloc/game/game_states.dart';
import 'package:wishflix/models/game_model.dart';
import 'package:wishflix/repository/game_repository.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(InitialGameState()) {
    on<GetAllGamesEvent>(_onGetAllGames);
  }

  final GameRepository _gameRepository = GameRepository();

  // lier les states à l'evenement GetAllGamesEvent
  void _onGetAllGames(GetAllGamesEvent event, Emitter<GameState> emit) async {
    // state de loading va etre écouté par l'UI
    emit(GameListLoadingState());
    try {
      //get data from repository
      List<Game> games = await _gameRepository.getAllGames();

      //put data in state to be communicated to UI
      emit(GameListSuccessState(games));
    } catch (e) {
      //put error in state to be communicated to UI
      emit(GameListErrorState(e.toString()));
    }
  }
}
