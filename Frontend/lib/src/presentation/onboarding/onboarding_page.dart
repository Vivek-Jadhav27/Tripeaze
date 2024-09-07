import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripeaze/src/utils/appcolors.dart';
import '../../config/router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;
  final controller = OnboardingItems();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: PageView.builder(
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    controller.items[index].image,
                    height: height * 0.4,
                    width: width * 0.8,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    controller.items[index].title,
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.06, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    controller.items[index].descriptions,
                    style: GoogleFonts.poppins(
                        color: Colors.grey, fontSize: width * 0.04),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(width * 0.05),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentIndex == 0
                ? TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryblue,
                        fontSize: width * 0.045,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => pageController.previousPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    child: Text(
                      'Previous',
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryblue,
                        fontSize: width * 0.045,
                      ),
                    ),
                  ),
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn),
              effect: WormEffect(
                dotHeight: width * 0.03,
                dotWidth: width * 0.03,
                activeDotColor: AppColors.primaryblue
              ),
            ),
            _currentIndex == 2
                ? TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.signin,
                    ),
                    child: Text(
                      'Finish',
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryblue,
                        fontSize: width * 0.045,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    child: Text(
                      'Next',
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryblue,
                        fontSize: width * 0.045,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Welcome to travel app",
        descriptions:
            "Embark on your next adventure with our travel app! Discover new destinations, plan seamless journeys, and create unforgettable memories. Welcome to a world of endless exploration!",
        image: "assets/svg/onboarding1.svg"),
    OnboardingInfo(
        title: "Select Your Resting place",
        descriptions:
            "Indulge in tranquility and comfort. Choose your perfect resting place with us, where serenity meets luxury. Select a haven that resonates with your soul. Your ultimate relaxation awaits.",
        image: "assets/svg/onboarding2.svg"),
    OnboardingInfo(
        title: "Enjoy Your Trip",
        descriptions:
            "Embrace the joy of travel! Explore new horizons, savor every moment, and create lasting memories. Your journey begins here. Enjoy the trip!",
        image: "assets/svg/onboarding3.svg"),
  ];
}

class OnboardingInfo {
  final String title;
  final String descriptions;
  final String image;

  OnboardingInfo(
      {required this.title, required this.descriptions, required this.image});
}
