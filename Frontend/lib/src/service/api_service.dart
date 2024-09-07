import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripeaze/src/model/hotel_model.dart';
import 'package:tripeaze/src/model/place_model.dart';
import '../model/itinerary_model.dart';
import '../model/trip_model.dart';

class APIService {
  static const String _baseUrl = 'http://192.168.35.127:8000';

  Future<List<Trip>> fetchTrips() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/trips/'));

      if (response.statusCode == 200) {
        List<dynamic> tripsJson = json.decode(response.body);
        return tripsJson.map((json) => Trip.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load trips. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Log error or handle exceptions accordingly
      print('Error fetching trips: $e');
      rethrow; // Rethrow to let the caller handle the error
    }
  }

  /// Fetches the itinerary based on the city and number of days.
  Future<List<Itinerary>> fetchItinerary(String city, int numDays) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'city': city, 'num_days': numDays}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        final itineraryList = (data['itinerary'] as List)
            .map((item) => Itinerary.fromJson(item))
            .toList();
        print(itineraryList);
        return itineraryList.isNotEmpty
            ? itineraryList
            : throw Exception('No itinerary data found');
      } else {
        throw Exception(
            'Failed to generate itinerary. Status Code: ${response.statusCode}, Response Body: ${response.body}');
      }
    } catch (e) {
      // Log error or handle exceptions accordingly
      print('Error fetching itinerary: $e');
      rethrow; // Rethrow to let the caller handle the error
    }
  }

  Future<List<Place>> fetchPopularPlaces() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/popular_places_view/'));

    if (response.statusCode == 200) {
      // Decode the JSON response to a Map
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Check if the 'popular_places' field exists and is a list
      if (jsonResponse['popular_places'] is List) {
        List<dynamic> placesData = jsonResponse['popular_places'];

        // print(placesData);
        // Convert the list to a List<Place>
        return placesData.map((place) => Place.fromJson(place)).toList();
      } else {
        throw Exception(
            'Invalid data format: popular_places key not found or is not a list');
      }
    } else {
      throw Exception('Failed to load places');
    }
  }

  Future<List<Hotel>> fetchPopularHotels() async {
    final response = await http.get(Uri.parse('$_baseUrl/popular-hotels/'));

    if (response.statusCode == 200) {
      // Decode the JSON response to a Map
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Check if the 'popular_places' field exists and is a list
      if (jsonResponse['popular_hotels'] is List) {
        List<dynamic> hotelsData = jsonResponse['popular_hotels'];

        print(hotelsData);
        return hotelsData.map((place) => Hotel.fromJson(place)).toList();
      } else {
        throw Exception(
            'Invalid data format: popular_places key not found or is not a list');
      }
    } else {
      throw Exception('Failed to load Hotels');
    }
  }
}
