import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/config/router.dart';
import 'package:tripeaze/src/model/user_model.dart';
import 'package:tripeaze/src/repository/firebase_repository.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseRepository repo = FirebaseRepository();


  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    if (_auth.currentUser != null) {
      Global.userID = _auth.currentUser!.uid;
      UserModel userModel = await repo.getProfile();
      Global.name = userModel.name;
      Global.email = userModel.email;
      Global.dob = userModel.dob;
      Global.profilePic = userModel.profilePic;
      Navigator.pushNamed(context, Routes.main);
    } else {
      Navigator.pushNamed(
        context,
        Routes.onboarding,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenWidth * 0.8,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signin.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects(
                  delay: const Duration(milliseconds: 1200),
                  offset: const Offset(0, -30),
                  curve: Curves.easeInCubic,
                  duration: const Duration(milliseconds: 900)),
              atRestEffect: WidgetRestingEffects.wave(),
              child: Text(
                'Tripeaze',
                style: GoogleFonts.oleoScript(
                  fontSize: screenWidth * 0.09,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}