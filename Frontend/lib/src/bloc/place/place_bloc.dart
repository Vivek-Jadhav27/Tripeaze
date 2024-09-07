import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripeaze/src/service/api_service.dart';
import 'place_event.dart';
import 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final APIService apiService = APIService();

  PlaceBloc() : super(PlaceLoading()) {
    on<FetchPopularPlaces>(_onFetchPopularPlaces);
  }

  Future<void> _onFetchPopularPlaces(
      FetchPopularPlaces event, Emitter<PlaceState> emit) async {
    try {
      final places = await apiService.fetchPopularPlaces();
      final hotels = await apiService.fetchPopularHotels();
      print(hotels);
      emit(PlaceLoaded(places: places , hotels: hotels));
    } catch (e) {
      emit(const PlaceError("Failed to fetch popular places"));
    }
  }
}
