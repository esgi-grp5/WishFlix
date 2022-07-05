import 'package:equatable/equatable.dart';
import 'package:wishflix/models/serie_model.dart';

abstract class SerieState extends Equatable {
  const SerieState();
}

//inital serie state
class InitialSerieState extends SerieState {
  @override
  List<Object> get props => [];
}

// serie loading state
class SerieListLoadingState extends SerieState {
  @override
  List<Object> get props => [];
}

// serieList success state
class SerieListSuccessState extends SerieState {
  final List<Serie> series;

  const SerieListSuccessState(this.series);

  @override
  List<Object> get props => [series];
}

//serieList error state
class SerieListErrorState extends SerieState {
  final String error;

  const SerieListErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// serieList success state
class SerieSuccessState extends SerieState {
  final Serie serie;

  const SerieSuccessState(this.serie);

  @override
  List<Object> get props => [serie];
}
