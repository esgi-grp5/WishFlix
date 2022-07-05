import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/bloc/music/music_events.dart';
import 'package:wishflix/bloc/music/music_states.dart';
import 'package:wishflix/models/music_model.dart';
import 'package:wishflix/repository/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(InitialMusicState()) {
    on<GetAllMusicsEvent>(_onGetAllMusics);
  }

  final MusicRepository _musicRepository = MusicRepository();

  // lier les states à l'evenement GetAllMusicsEvent
  void _onGetAllMusics(
      GetAllMusicsEvent event, Emitter<MusicState> emit) async {
    // state de loading va etre écouté par l'UI
    emit(MusicListLoadingState());
    try {
      //get data from repository
      List<Music> musics = await _musicRepository.getAllMusics();

      //put data in state to be communicated to UI
      emit(MusicListSuccessState(musics));
    } catch (e) {
      //put error in state to be communicated to UI
      emit(MusicListErrorState(e.toString()));
    }
  }
}
