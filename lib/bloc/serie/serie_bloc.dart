import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishflix/bloc/serie/serie_events.dart';
import 'package:wishflix/bloc/serie/serie_states.dart';
import 'package:wishflix/models/serie_model.dart';
import 'package:wishflix/repository/serie_repository.dart';

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  SerieBloc() : super(InitialSerieState()) {
    on<GetAllSeriesEvent>(_onGetAllSeries);
  }

  final SerieRepository _serieRepository = SerieRepository();

  // lier les states à l'evenement GetAllSeriesEvent
  void _onGetAllSeries(
      GetAllSeriesEvent event, Emitter<SerieState> emit) async {
    // state de loading va etre écouté par l'UI
    emit(SerieListLoadingState());
    try {
      //get data from repository
      List<Serie> series = await _serieRepository.getAllSeries();

      //put data in state to be communicated to UI
      emit(SerieListSuccessState(series));
    } catch (e) {
      //put error in state to be communicated to UI
      emit(SerieListErrorState(e.toString()));
    }
  }
}
