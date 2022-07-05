import 'package:equatable/equatable.dart';
import 'package:wishflix/models/serie_model.dart';

abstract class SerieEvent extends Equatable {
  const SerieEvent();
}

//add serie event
class AddSerieEvent extends SerieEvent {
  final Serie serie;

  const AddSerieEvent({required this.serie});

  @override
  List<Object> get props => [Serie];
}

// remove serie event
class RemoveSerieEvent extends SerieEvent {
  final int serieId;

  const RemoveSerieEvent({required this.serieId});

  @override
  List<Object> get props => [serieId];
}

//get all series event
class GetAllSeriesEvent extends SerieEvent {
  @override
  List<Object> get props => [];
}
