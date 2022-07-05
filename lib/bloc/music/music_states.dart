import 'package:equatable/equatable.dart';
import 'package:wishflix/models/music_model.dart';

abstract class MusicState extends Equatable {
  const MusicState();
}

//inital music state
class InitialMusicState extends MusicState {
  @override
  List<Object> get props => [];
}

// music loading state
class MusicListLoadingState extends MusicState {
  @override
  List<Object> get props => [];
}

// musicList success state
class MusicListSuccessState extends MusicState {
  final List<Music> musics;

  const MusicListSuccessState(this.musics);

  @override
  List<Object> get props => [musics];
}

//musicList error state
class MusicListErrorState extends MusicState {
  final String error;

  const MusicListErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// musicList success state
class MusicSuccessState extends MusicState {
  final Music music;

  const MusicSuccessState(this.music);

  @override
  List<Object> get props => [music];
}
