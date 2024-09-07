import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
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
                          color: Colors.white,
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
                    'Customer Support',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryblue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.06,
                right: width * 0.06,
              ),
              child: Container(
                width: 343,
                height: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.06)),
                  boxShadow: const [
                    BoxShadow(
                        color:
                            Color.fromRGBO(64, 123, 255, 0.20000000298023224),
                        offset: Offset(0, 0),
                        blurRadius: 20)
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: SvgPicture.asset(
                        "assets/svg/customer1.svg",
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      child: Text(
                        'Customer Support',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryblue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: width * 0.06,
                        right: width * 0.06,
                      ),
                      child: Text(
                        'Experience seamless travel with our app! Our dedicated support team is here 24/7 to assist you. From itinerary changes to travel tips, we\'ve got you covered. Happy travels!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.06)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(
                                  122, 47, 21, 0.30000001192092896),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Outsource now',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.06,
                right: width * 0.06,
                bottom: height * 0.03,
              ),
              child: Container(
                width: 343,
                height: 343,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.06)),
                  boxShadow: const [
                    BoxShadow(
                        color:
                            Color.fromRGBO(64, 123, 255, 0.20000000298023224),
                        offset: Offset(0, 0),
                        blurRadius: 20)
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.03),
                      child: SvgPicture.asset(
                        "assets/svg/customer2.svg",
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      child: Text(
                        'Phone Answering',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppColors.primaryblue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.01,
                        left: width * 0.06,
                        right: width * 0.06,
                      ),
                      child: Text(
                        '"Efficient phone support with dedicated agents ready to assist you. Quick solutions and friendly service for a seamless customer experience."',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1),
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                        top: height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.06)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(
                                  122, 47, 21, 0.30000001192092896),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Number',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
