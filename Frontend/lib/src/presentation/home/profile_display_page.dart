import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:tripeaze/src/presentation/home/profile_edit_page.dart';
import 'package:tripeaze/src/presentation/spalshscreen/splash_screen.dart';
import 'package:tripeaze/src/repository/firebase_repository.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

import '../../utils/constants.dart';

class ProfileDisplayPage extends StatefulWidget {
  const ProfileDisplayPage({super.key});

  @override
  State<ProfileDisplayPage> createState() => _ProfileDisplayPageState();
}

class _ProfileDisplayPageState extends State<ProfileDisplayPage> {
  final FirebaseRepository repository = FirebaseRepository();

  @override
  void initState() {
    super.initState();
    // Load profile data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.05, right: width * 0.06, left: width * 0.06),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      size: width * 0.07,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Navigate back to the previous screen
                    },
                  ),
                  SizedBox(width: width * 0.04), // Added for spacing
                  Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: width * 0.20,
                    backgroundImage:
                        // provider.profilePic != null
                        //     ? NetworkImage(provider.profilePic!):
                        const AssetImage('assets/images/user.png')
                            as ImageProvider, // Use a default image if profilePic is null
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.06,
                  bottom: height * 0.023,
                  right: width * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: height *
                          0.03), // Spacing between profile picture and text
                  Text(
                    'Name',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(35, 35, 35, 1),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Global.name,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: width * 0.045,
                    ),
                  ),
                  SizedBox(height: height * 0.02), // Spacing between sections
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(35, 35, 35, 1),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Global.email,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: width * 0.045,
                    ),
                  ),
                  SizedBox(height: height * 0.02), // Spacing between sections
                  // Text(
                  //   'Date of Birth',
                  //   style: GoogleFonts.poppins(
                  //     color: const Color.fromRGBO(35, 35, 35, 1),
                  //     fontSize: width * 0.045,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // // Text(
                  //   Global.dob,
                  //   style: GoogleFonts.poppins(
                  //     color: Colors.black,
                  //     fontSize: width * 0.045,
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const EditProfilePage()));
                  //   },
                  //   child: Container(
                  //     height: height * 0.06,
                  //     width: width,
                  //     margin: EdgeInsets.only(
                  //         top: height * 0.05,
                  //         right: width * 0.06,
                  //         left: width * 0.06),
                  //     padding: EdgeInsets.only(
                  //         left: width * 0.04, right: width * 0.01),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryblue,
                  //       borderRadius:
                  //           BorderRadius.all(Radius.circular(width * 0.04)),
                  //       border: Border.all(color: Colors.white),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'Edit Profile',
                  //         style: GoogleFonts.poppins(
                  //           color: Colors.white,
                  //           fontSize: width * 0.045,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  
                  GestureDetector(
                    onTap: () async {
                      bool result = await repository.signOut();
                      if (result) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("error")));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: height * 0.02,
                        left: width * 0.04,
                        right: width * 0.04,
                        bottom: height * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        color: AppColors.primaryblue,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.01, horizontal: width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: width * 0.07,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                  fontSize: width * 0.05, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
