import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/repository/firebase_repository.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

import '../../model/itinerary_model.dart';
import '../../model/place_model.dart';
import '../../model/reastaurant_model.dart';

class ItineraryDisplay extends StatefulWidget {
  final List<Itinerary> itinerary;

  const ItineraryDisplay({super.key, required this.itinerary});

  @override
  _ItineraryDisplayState createState() => _ItineraryDisplayState();
}

class _ItineraryDisplayState extends State<ItineraryDisplay> {
  String saveButtonText = 'Save';
  final FirebaseRepository repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Itinerary',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: _showSaveDialog,
            child: Text(
              saveButtonText,
              style: GoogleFonts.poppins(color: AppColors.primaryblue),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.01),
                child: Text(
                  'Itinerary Details',
                  style: GoogleFonts.poppins(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.itinerary.length,
                  itemBuilder: (context, index) {
                    final currentItinerary = widget.itinerary[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Day ${currentItinerary.day}",
                          style: GoogleFonts.poppins(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        _buildExpandableSection(
                            'Breakfast', currentItinerary.breakfast),
                        _buildExpandableSection('Morning Activity',
                            currentItinerary.morningActivity),
                        _buildExpandableSection(
                            'Lunch', currentItinerary.lunch),
                        _buildExpandableSection('Afternoon Activity',
                            currentItinerary.afternoonActivity),
                        _buildExpandableSection(
                            'Dinner', currentItinerary.dinner),
                        const Divider(), // Adds a divider between days
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, dynamic item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        children: [
          ListTile(
            title: Text(
              'Name: ${item.name}',
              style: GoogleFonts.poppins(),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item is Place) ...[
                  Text(
                    'Description: ${item.description}',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'Ratings: ${item.googleReviewRating}',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'Type: ${item.placeType}',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'Entrance Fee: ${item.entranceFee}',
                    style: GoogleFonts.poppins(),
                  ),
                ],
                if (item is Restaurant)
                  Text(
                    'Location: ${item.location}',
                    style: GoogleFonts.poppins(),
                  ),
                ElevatedButton(
                  onPressed: () => _launchURL(item.url),
                  child: Text(
                    'View on Google',
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    // Uncomment and use the url_launcher package to launch URLs
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Future<void> _showSaveDialog() async {
    TextEditingController tripNameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Save Trip',
            style: GoogleFonts.poppins(),
          ),
          content: TextField(
            controller: tripNameController,
            decoration: InputDecoration(
              hintText: 'Enter trip name',
              hintStyle: GoogleFonts.poppins(),
            ),
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  saveButtonText = 'Saved';
                });
                repository.saveTrip(tripNameController.text, widget.itinerary );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Save',
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        );
      },
    );
  }
}
