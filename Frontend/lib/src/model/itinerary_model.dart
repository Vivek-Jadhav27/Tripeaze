import 'hotel_model.dart';
import 'place_model.dart';
import 'reastaurant_model.dart';

class Itinerary {
  final int day;
  final Hotel hotel;
  final Restaurant breakfast;
  final Place morningActivity;
  final Restaurant lunch;
  final Place afternoonActivity;
  final Restaurant dinner;

  Itinerary({
    required this.day,
    required this.hotel,
    required this.breakfast,
    required this.morningActivity,
    required this.lunch,
    required this.afternoonActivity,
    required this.dinner,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      day: json['day'] ?? 1,
      hotel: Hotel.fromJson(json['hotel'] ?? []) ,
      breakfast: Restaurant.fromJson(json['breakfast']?? []),
      morningActivity: Place.fromJson(json['morning_activity']?? []),
      lunch: Restaurant.fromJson(json['lunch']?? []),
      afternoonActivity: Place.fromJson(json['afternoon_activity']?? []),
      dinner: Restaurant.fromJson(json['dinner']?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'hotel': hotel.toJson(),
      'breakfast': breakfast.toJson(),
      'morning_activity': morningActivity.toJson(),
      'lunch': lunch.toJson(),
      'afternoon_activity': afternoonActivity.toJson(),
      'dinner': dinner.toJson(),
    };
  }
}
