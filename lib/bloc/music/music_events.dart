import 'package:equatable/equatable.dart';
import 'package:wishflix/models/music_model.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();
}

//add music event
class AddMusicEvent extends MusicEvent {
  final Music music;

  const AddMusicEvent({required this.music});

  @override
  List<Object> get props => [Music];
}

// remove music event
class RemoveMusicEvent extends MusicEvent {
  final int musicId;

  const RemoveMusicEvent({required this.musicId});

  @override
  List<Object> get props => [musicId];
}

//get all musics event
class GetAllMusicsEvent extends MusicEvent {
  @override
  List<Object> get props => [];
}
