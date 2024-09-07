import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/config/router.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: SvgPicture.asset(
                    'assets/svg/fogot.svg',
                    width: width * 0.3,
                    height: height * 0.3,
                  )),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: width * 0.06, bottom: height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(35, 35, 35, 1),
                      fontSize: width * 0.085,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Reset your Password and make it strong.',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(149, 149, 149, 1),
                      fontSize: width * 0.040,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.06),
              child: Text(
                'Password Requirement:',
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(35, 35, 35, 1),
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: width * 0.06, bottom: height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRequirementText('• At least 8 characters'),
                  _buildRequirementText('• At least 1 uppercase character'),
                  _buildRequirementText('• At least 1 number'),
                ],
              ),
            ),
            _buildPasswordField('New Password', width, height),
            _buildPasswordField('Re-enter Password', width, height),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.otp);
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.9,
                  margin: EdgeInsets.only(top: height * 0.018),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.primaryblue,
                    border: Border.all(
                      color: const Color.fromRGBO(230, 232, 231, 1),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Inter',
                        fontSize: width * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.015),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Back to ',
                        style: TextStyle(
                          color: const Color.fromRGBO(108, 108, 108, 1),
                          fontSize: width * 0.050,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, Routes.signin);
                          },
                        text: 'Sign in',
                        style: TextStyle(
                          color: AppColors.primaryblue,
                          fontSize: width * 0.050,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildPasswordField(String labelText, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: TextField(
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        style: TextStyle(
          fontSize: width * 0.025,
        ),
      ),
    );
  }

  Text _buildRequirementText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: const Color.fromRGBO(35, 35, 35, 1),
        fontSize: MediaQuery.of(context).size.width * 0.045,
      ),
    );
  }
}
