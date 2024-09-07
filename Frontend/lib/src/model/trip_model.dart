import 'itinerary_model.dart'; 

class Trip {
  final String id;
  final String tripName;
  final List<Itinerary> itinerary;

  Trip({
    required this.id,
    required this.tripName,
    required this.itinerary,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] ?? '',
      tripName: json['tripName'] ?? '',
      itinerary: (json['itinerary'] as List<dynamic>?)
          ?.map((item) => Itinerary.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  // Method to convert a Trip to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripName': tripName,
      'itinerary': itinerary.map((item) => item.toJson()).toList(),
    };
  }
}
