import 'package:flutter/material.dart';
import 'package:tripeaze/src/utils/appcolors.dart';

Widget buildSegment(double screenwidth, double screenheight, int index , int position) {
    return Container(
        width: screenwidth,
        height: screenheight,
        margin: EdgeInsets.symmetric(horizontal: 8), // Adjust margin as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: index < position + 1
              ? Colors.white
              : AppColors.primaryblue // Color for positions 0 to 4
          ,
          border: Border.all(
            color: index < position + 1
                ? AppColors.primaryblue // Color for positions 0 to 4
                : Colors.white,
            width: 1,
          ),
        ));
  }