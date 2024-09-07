import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.075),
              _buildHeader(width),
              SizedBox(height: height * 0.02),
              _buildImage(height, width),
              SizedBox(height:  height * 0.02),
              _buildTermsContent(width),
              SizedBox(height:  height * 0.02),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Container(
            width: width * 0.10,
            height: width * 0.10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.06),
              boxShadow:const  [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  offset: Offset(0, 0),
                  blurRadius: 25,
                ),
              ],
            ),
            child: Icon(
              CupertinoIcons.arrow_left,
              size: width * 0.07,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Terms and Conditions',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: AppColors.primaryblue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: width * 0.10),
      ],
    );
  }

  Widget _buildImage(double height, double width) {
    return Image.network(
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      width: width,
      height: height * 0.3,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTermsContent(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions for Near Me',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('1. User Agreement:'),
        _buildSectionContent(
          'By accessing or using Near Me, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, please refrain from using the app.',
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('2. Account Registration:'),
        _buildSectionContent(
          'Users must create an account to access certain features of the app. You are responsible for maintaining the confidentiality of your account information and ensuring its security.',
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('3. Travel Bookings:'),
        _buildSectionContent(
          'Near Me facilitates travel bookings, but we are not responsible for the services provided by third-party vendors. Please review and comply with the terms and conditions of these providers.',
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('4. Payment and Refunds:'),
        _buildSectionContent(
          'Payment for services is processed through secure channels. Refund policies vary, so please check with the specific service provider for details.',
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('5. User Conduct:'),
        _buildSectionContent(
          'Users must adhere to ethical and lawful behavior while using the app. Any misuse, abuse, or violation may result in account suspension.',
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('6. Intellectual Property:'),
        _buildSectionContent(
          'All content, trademarks, and intellectual property on Near Me are the property of the app owner. Unauthorized use is strictly prohibited.',
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'By using Near Me, you agree to these terms, creating a safe and enjoyable experience for all users. Safe travels!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding:  EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: Color.fromRGBO(202, 202, 202, 1),
        thickness: 3,
      ),
    );
  }
}