import 'package:flutter/material.dart';
import 'package:tripeaze/src/model/trip_model.dart';
import 'package:tripeaze/src/repository/firebase_repository.dart';
import 'itinerary_display_page.dart'; 

class TripPage extends StatefulWidget {

  const TripPage({super.key,});

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  late Future<List<Trip>> _tripsFuture;
  final FirebaseRepository repository = FirebaseRepository();

  @override
  void initState() {
    super.initState();
    _tripsFuture = repository.fetchUserTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Trips'),
      ),
      body: FutureBuilder<List<Trip>>(
        future: _tripsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved trips'));
          } else {
            final trips = snapshot.data!;
            return ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItineraryDisplay(
                          itinerary: trip
                              .itinerary, // Adjust according to your data structure
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), 
                    ),                    
                    child: Text(
                      trip.tripName,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
