import 'package:flutter/material.dart';

import 'appcolors.dart';
 Widget buildButtons(double screenWidth, double screenHeight , int position) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.053,
        vertical: screenHeight * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              
            },
            child: Container(
              width: screenWidth * 0.300,
              height: screenHeight * 0.057,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                border: Border.all(
                  color: position != 0
                      ? AppColors.primaryblue
                      : Color.fromRGBO(171, 171, 171, 1),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: position != 0
                        ? AppColors.primaryblue
                        : Color.fromRGBO(171, 171, 171, 1),
                    fontFamily: 'Inter',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
            },
            child: Container(
              width: screenWidth * 0.300,
              height: screenHeight * 0.057,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primaryblue,
                border: Border.all(
                  color: AppColors.primaryblue,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  position == 2 ? 'Submit' : 'Next',
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  