import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/config/router.dart';
import 'package:tripeaze/src/model/hotel_model.dart';
import 'package:tripeaze/src/presentation/home/hotels_details_page.dart';
import 'package:tripeaze/src/presentation/home/place_details_page.dart';
import 'package:tripeaze/src/presentation/home/trip_list_page.dart';
import 'package:tripeaze/src/presentation/home/view_all_page.dart';
// import 'package:tripeaze/src/repository/firebase_repository.dart';
import 'package:tripeaze/src/utils/appcolors.dart';
import '../../bloc/place/place_bloc.dart';
import '../../bloc/place/place_event.dart';
import '../../bloc/place/place_state.dart';
import '../../model/place_model.dart';
import '../../utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PlaceBloc()..add(FetchPopularPlaces()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlaceLoaded) {
              final places = state.places;
              final hotels = state.hotels;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, screenheight, screenwidth),
                    _buildCarousel(context, places),
                    _buildSectionTitle('Top Destinations', onViewAll: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllPage(
                                    places: places,
                                    hotels: hotels,
                                    flage: 1,
                                  )));
                    }),
                    _buildHorizontalList(places, screenwidth, screenheight),
                    _buildSectionTitle('Top Hotels', onViewAll: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAllPage(
                                    places: places,
                                    hotels: hotels,
                                    flage: 2,
                                  )));
                    }),
                    _buildHorizontalHList(hotels, screenwidth, screenheight),
                  ],
                ),
              );
            } else if (state is PlaceError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        drawer: _buildDrawer(context, screenwidth, screenheight),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double height, double width) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.07, left: width * 0.06, right: width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                width: width * 0.12,
                height: width * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.06)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 0),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: Icon(
                  CupertinoIcons.line_horizontal_3,
                  size: width * 0.07,
                ),
              ),
            ),
          ),
          
          // GestureDetector(
          //   onTap: () => Navigator.pushNamed(context, Routes.search),
          //   child: Container(
          //     width: width * 0.12,
          //     height: width * 0.12,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.all(Radius.circular(width * 0.06)),
          //         boxShadow: const [
          //           BoxShadow(
          //               color: Color.fromRGBO(0, 0, 0, 0.25),
          //               offset: Offset(0, 0),
          //               blurRadius: 25)
          //         ]),
          //     child: Icon(
          //       CupertinoIcons.search,
          //       size: width * 0.07,
          //     ),
          //   ),
          // ),
        
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, List<Place> places) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: false,
        ),
        items: places
            .take(5)
            .map((place) => _buildCarouselItem(context, place))
            .toList(),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, Place place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(place: place)));
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: <Widget>[
              Image.network(
                place.imgUrl,
                fit: BoxFit.cover,
                width: 1000.0,
                height: 200.0,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    place.name,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'View all',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.primaryblue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(
      List<Place> places, double screenwidth, double screenheight) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildPlaceCard(
                context, places[index], screenwidth, screenheight),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalHList(
      List<Hotel> hotels, double screenwidth, double screenheight) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildHotelCard(
                context, hotels[index], screenwidth, screenheight),
          );
        },
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

  Widget _buildDrawer(BuildContext context, double width, double height) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.05,
                      left: width * 0.05,
                      right: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          size: width * 0.09,
                          color: const Color.fromRGBO(93, 114, 133, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.01,
                    left: width * 0.05,
                    right: width * 0.05,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.1)),
                        child: Image.network(Global.profilePic,
                            width: 50, height: 50, fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/user.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Global.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Global.email,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.house,
                    color: const Color.fromRGBO(93, 114, 133, 1),
                    size: width * 0.07,
                  ),
                  title: Text(
                    'List of Trip places',
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.05,
                        color: const Color.fromRGBO(93, 114, 133, 1)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.support_agent,
                    color: const Color.fromRGBO(93, 114, 133, 1),
                    size: width * 0.07,
                  ),
                  title: Text(
                    'Customer Support',
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.05,
                        color: const Color.fromRGBO(93, 114, 133, 1)),
                  ),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.customersupport),
                ),
                ListTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    color: const Color.fromRGBO(93, 114, 133, 1),
                    size: width * 0.07,
                  ),
                  title: Text(
                    'Privacy Policy',
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.05,
                        color: const Color.fromRGBO(93, 114, 133, 1)),
                  ),
                  onTap: () => Navigator.pushNamed(context, Routes.policy),
                ),
                ListTile(
                  leading: Icon(
                    Icons.article,
                    color: const Color.fromRGBO(93, 114, 133, 1),
                    size: width * 0.07,
                  ),
                  title: Text(
                    'Term and Conditions',
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.05,
                        color: const Color.fromRGBO(93, 114, 133, 1)),
                  ),
                  onTap: () => Navigator.pushNamed(context, Routes.terms),
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.settings,
                //     color: const Color.fromRGBO(93, 114, 133, 1),
                //     size: width * 0.07,
                //   ),
                //   title: Text(
                //     'Setting',
                //     style: GoogleFonts.poppins(
                //         fontSize: width * 0.05,
                //         color: const Color.fromRGBO(93, 114, 133, 1)),
                //   ),
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
