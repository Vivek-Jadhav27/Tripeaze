import 'package:equatable/equatable.dart';
import 'package:tripeaze/src/model/hotel_model.dart';
import '../../model/place_model.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object?> get props => [];
}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<Place> places;
  final List<Hotel> hotels;

  const PlaceLoaded({required this.places, required this.hotels});

  @override
  List<Object?> get props => [places];
}

class PlaceError extends PlaceState {
  final String message;

  const PlaceError(this.message);

  @override
  List<Object?> get props => [message];
}
