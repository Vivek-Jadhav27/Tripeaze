import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/model/hotel_model.dart';
import 'package:tripeaze/src/presentation/home/hotels_details_page.dart';
import 'package:tripeaze/src/presentation/home/place_details_page.dart';

import '../../model/place_model.dart';

class ViewAllPage extends StatefulWidget {
  final List<Place> places;
  final List<Hotel> hotels;
  final int flage;
  const ViewAllPage({super.key, required this.places, required this.hotels, required this.flage});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('View All'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 8.0, // Horizontal spacing between items
            mainAxisSpacing: 8.0, // Vertical spacing between items
            childAspectRatio: 0.75, // Adjust item height/width ratio if needed
          ),
          itemCount: widget.flage ==1 ? widget.places.length : widget.hotels.length , // Number of items in the grid
          itemBuilder: (context, index) {
            return widget.flage == 1 ? _buildPlaceCard(context, widget.places[index], width, height):_buildHotelCard(context, widget.hotels[index], width, height) ;
          },
        ),
      ),
    );
  }

  Widget _buildPlaceCard(
      BuildContext context, Place place, double width, double height) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PlaceDetailsPage(place: place))),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
              child: Stack(
                children: [
                  Image.network(
                    place.imgUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: height * 0.17,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                        size: width * 0.1,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.03, top: height * 0.01),
              child: Text(
                place.name,
                style: GoogleFonts.poppins(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.03),
              child: Text(
                '${place.city}, ${place.state}',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.035,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildHotelCard(
      BuildContext context, Hotel hotel, double width, double height) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HotelsDetailsPage(
                    place: hotel,
                  ))),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.05)),
              child: Stack(
                children: [
                  Image.network(
                    'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: height * 0.17,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                        size: width * 0.1,
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.03, top: height * 0.01),
              child: Text(
                hotel.name,
                style: GoogleFonts.poppins(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.03),
              child: Text(
                '${hotel.locality}, ${hotel.city}',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.035,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
