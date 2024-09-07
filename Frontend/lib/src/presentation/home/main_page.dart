import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tripeaze/src/bloc/home/home_bloc.dart';
import 'package:tripeaze/src/bloc/home/home_state.dart';
import 'package:tripeaze/src/presentation/home/home_page.dart';
import 'package:tripeaze/src/presentation/home/plan_trip_page.dart';
// import 'package:tripeaze/src/presentation/home/popular_places.dart';
import 'package:tripeaze/src/presentation/home/profile_display_page.dart';
// import 'package:tripeaze/src/presentation/home/profile_page.dart';
// import 'package:tripeaze/src/presentation/home/wishlist_page.dart';
import 'package:tripeaze/src/utils/appcolors.dart';
import 'package:tripeaze/src/utils/constants.dart';

import '../../bloc/home/home_event.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List body = [
    const HomePage(),
     const PlanTripPage(),
    // const WishlistPage(),
    const ProfileDisplayPage(),
  ];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is HomeLoaded) {
          Global.userID = state.user.uid;
          Global.name = state.user.name;
          Global.email = state.user.email;
          Global.profilePic = state.user.profilePic;
          Global.dob = state.user.dob;
          print("${Global.name} ${Global.email} ${Global.dob}");
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: body[_selectedIndex],
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: Colors.white,
            margin: EdgeInsets.only(
                bottom: height * 0.01,
                right: width * 0.04,
                left: width * 0.04,
                top: height * 0.01),
            selectedItemColor: AppColors.primaryblue,
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() => _selectedIndex = i),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.home),
                title: Text(
                  "Home",
                  style: GoogleFonts.poppins(),
                ),
              ),
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.add),
                title: Text(
                  "Add Trip",
                  style: GoogleFonts.poppins(),
                ),
              ),
              // SalomonBottomBarItem(
              //   icon: const Icon(
              //     CupertinoIcons.heart,
              //   ),
              //   title: Text(
              //     "Likes",
              //     style: GoogleFonts.poppins(),
              //   ),
              // ),
              SalomonBottomBarItem(
                icon: const Icon(CupertinoIcons.person),
                title: Text(
                  "Profile",
                  style: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
