import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/config/router.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Widget displayedWidget;
    switch (currentPage) {
      case 0:
        displayedWidget = verifyEmail(height, width, () {
          setState(() {
            currentPage = 1;
          });
        });
        break;
      case 1:
        displayedWidget = verifyotp(height, width, () {
          setState(() {
            currentPage = 2;
          });
        });
        break;
      case 2:
      default:
        displayedWidget = successOTP(context, height, width);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: displayedWidget),
    );
  }
}

Widget successOTP(BuildContext context, double height, double width) {
  return SizedBox(
    width: width,
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/success.png',
          width: width * 0.3,
          height: height * 0.3,
        ),
        Text(
          'Success!',
          style: GoogleFonts.poppins(
            color: const Color.fromRGBO(35, 35, 35, 1),
            fontSize: width * 0.085,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Congratulations! You have been successfully authenticated.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color.fromRGBO(149, 149, 149, 1),
            fontSize: width * 0.050,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.home),
          child: Container(
            height: height * 0.07,
            width: width * 0.9,
            margin: EdgeInsets.only(top: height * 0.018),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: AppColors.primaryblue,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                'Continue',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget verifyEmail(double height, double width, VoidCallback onVerifyPressed) {
  TextEditingController emailController = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/otp1.svg',
            width: width * 0.3,
            height: height * 0.3,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: width * 0.06, bottom: height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(35, 35, 35, 1),
                fontSize: width * 0.085,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Enter email and phone number to send one time Password.',
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(149, 149, 149, 1),
                fontSize: width * 0.050,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            right: width * 0.03, left: width * 0.03, bottom: height * 0.01),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: GoogleFonts.poppins(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                width * 0.05,
              )),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                width * 0.05,
              )),
              borderSide: const BorderSide(color: AppColors.primaryblue),
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: width * 0.025,
          ),
        ),
      ),
      Center(
        child: Container(
          height: height * 0.07,
          width: width * 0.9,
          margin: EdgeInsets.only(top: height * 0.03),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: AppColors.primaryblue,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Center(
            child: TextButton(
              onPressed: onVerifyPressed,
              child: Text(
                'Verify',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget verifyotp(double height, double width, VoidCallback onVerifyOTPPressed) {
  TextEditingController otpController = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(top: height * 0.05, bottom: height * 0.03),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/otp2.svg',
            width: width * 0.3,
            height: height * 0.3,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: width * 0.06, bottom: height * 0.03),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verification Code',
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(35, 35, 35, 1),
                  fontSize: width * 0.085,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We have sent the verification code to your email address.',
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(149, 149, 149, 1),
                  fontSize: width * 0.050,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]),
      ),
      Padding(
        padding: EdgeInsets.only(
            right: width * 0.03, left: width * 0.03, bottom: height * 0.01),
        child: TextField(
          controller: otpController,
          decoration: InputDecoration(
            labelText: 'OTP',
            labelStyle: GoogleFonts.poppins(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                width * 0.05,
              )),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                width * 0.05,
              )),
              borderSide: const BorderSide(color: AppColors.primaryblue),
            ),
          ),
          style: GoogleFonts.poppins(
            fontSize: width * 0.025,
          ),
        ),
      ),
      Center(
        child: Container(
          height: height * 0.07,
          width: width * 0.9,
          margin: EdgeInsets.only(top: height * 0.03),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: AppColors.primaryblue,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Center(
            child: TextButton(
              onPressed: onVerifyOTPPressed,
              child: Text(
                'Verify OTP',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
