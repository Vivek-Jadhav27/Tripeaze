import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: ListView.builder(
        itemCount: 14,
        itemBuilder: (context, index) {
          return wishlistCard(width, height);
        },
      ),
    );
  }
}

Widget wishlistCard(double width, double height) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: width * 0.04),
    padding: EdgeInsets.all(width * 0.02),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(width * 0.05),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: width * 0.3,
              height: height * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
              margin: EdgeInsets.only(right: width * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.05),
                child: Image.network(
                  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.045, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'Product Description',
                  style: GoogleFonts.poppins(
                    fontSize: width * 0.040, 
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        Icon(
          CupertinoIcons.delete,
          color: Colors.red,
          size: width * 0.07, // Responsive icon size
        ),
      ],
    ),
  );
}
