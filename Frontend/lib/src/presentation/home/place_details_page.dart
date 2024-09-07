import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/model/place_model.dart';

class PlaceDetailsPage extends StatefulWidget {
  final Place place;
  const PlaceDetailsPage({super.key, required this.place});

  @override
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.07),
                    bottomRight: Radius.circular(width * 0.07),
                  ),
                  child: Image.network(
                    widget.place.imgUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: height * 0.4,
                  ),
                ),
                Positioned(
                  top: height * 0.04,
                  left: width * 0.02,
                  right: width * 0.02,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: width * 0.1,
                        ),
                        color: Colors.white,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       height: width * 0.1,
                      //       width: width * 0.1,
                      //       margin: EdgeInsets.only(right: width * 0.03),
                      //       decoration: BoxDecoration(
                      //         color: const Color.fromRGBO(255, 255, 255, 0.5),
                      //         borderRadius: BorderRadius.all(
                      //             Radius.circular(width * 0.05)),
                      //       ),
                      //       child: Icon(
                      //         Icons.share_sharp,
                      //         color: Colors.black,
                      //         size: width * 0.07,
                      //       ),
                      //     ),
                      //     Container(
                      //       height: width * 0.1,
                      //       width: width * 0.1,
                      //       decoration: BoxDecoration(
                      //         color: const Color.fromRGBO(255, 255, 255, 0.5),
                      //         borderRadius: BorderRadius.all(
                      //             Radius.circular(width * 0.05)),
                      //       ),
                      //       child: Icon(
                      //         CupertinoIcons.heart,
                      //         color: Colors.black,
                      //         size: width * 0.08,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.02),
                    child: Text(
                      widget.place.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.02),
              child: Text(
                widget.place.description,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(59, 58, 58, 1),
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: const Divider(
                color: Color.fromRGBO(202, 202, 202, 1),
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.02),
                    child: Text(
                      widget.place.googleReviewRating.toString(),
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(59, 58, 58, 1),
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PannableRatingBar(
                    rate: widget.place.googleReviewRating,
                    items: List.generate(
                      5,
                      (index) => const RatingWidget(
                        selectedColor: Color.fromRGBO(255, 203, 69, 1),
                        unSelectedColor: Colors.white,
                        child: Icon(
                          CupertinoIcons.star_fill,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '20',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(59, 58, 58, 1),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Location: ',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(59, 58, 58, 1),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.place.city} ${widget.place.state} , India',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(59, 58, 58, 1),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: const Divider(
                color: Color.fromRGBO(202, 202, 202, 1),
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
