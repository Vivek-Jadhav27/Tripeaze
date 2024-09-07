import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.075, right: width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: width * 0.10,
                      height: width * 0.10,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * 0.06)),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 0),
                                blurRadius: 25)
                          ]),
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        size: width * 0.07,
                      ),
                    ),
                  ),
                  Text(
                    'About This Policy',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Color.fromRGBO(64, 133, 255, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.02,
                bottom: height * 0.02,
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                width: width,
                height: height * 0.3,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildPolicyText(
                    'Welcome to Near Me! At Near Me, we prioritize your privacy and aim to provide you with a seamless and enjoyable travel experience. This policy outlines our commitment to safeguarding your personal information and ensuring transparency in how we collect, use, and protect your data.',
                   FontWeight.bold), 
                  _buildPolicyText(
                    'We understand the importance of trust in our relationship with you, our valued user. Our privacy policy is designed to inform you about the types of information we may collect, the purposes for which we use it, and the measures we take to keep it secure. Whether you\'re planning your next adventure, booking accommodations, or exploring local recommendations, we want you to feel confident that your data is handled responsibly.',
                   FontWeight.normal),
                  _buildPolicyText(
                    'Here, you\'ll find details on the data we collect, such as your contact information, travel preferences, and location data, and how we use this information to enhance your travel experience. We also explain your rights and choices regarding the information you share with us.',
                   FontWeight.normal),
                  _buildPolicyText(
                    'Our commitment to privacy is an integral part of our mission to make travel planning simple and enjoyable. If you have any questions or concerns about our policy, please don\'t hesitate to reach out to our dedicated support team.',
                  FontWeight.normal),
                  const Padding(
                    padding: EdgeInsets.only(
                         left: 15, right: 15, bottom: 10),
                    child: Divider(
                      color: Color.fromRGBO(202, 202, 202, 1),
                      thickness: 3,
                    ),
                  ),
                  _buildPolicyText(
                      'Thank you for choosing Near Me for your travel needs. Happy travels!', FontWeight.normal),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyText(String text , FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 13,
          letterSpacing: 0,
          fontWeight: fontWeight,
          height: 1.0,
        ),
      ),
    );
  }
}
