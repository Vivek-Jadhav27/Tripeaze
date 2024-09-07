import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/presentation/home/itinerary_display_page.dart';
import 'package:tripeaze/src/service/api_service.dart';
import '../../utils/appcolors.dart';

class PlanTripPage extends StatefulWidget {
  const PlanTripPage({super.key});

  @override
  State<PlanTripPage> createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
  final List<String> _cities = [
    'Delhi',
    'Hyderabad',
    'Kolkata',
    'Mumbai',
    'Bangalore',
    'Ahmedabad',
    'Jaipur',
    'Gangtok',
    'Amritsar',
    'Guwahati',
    'Mathura',
    'Patna',
    'Lucknow',
    'Bhopal',
    'Agra',
    'Bhubaneswar',
    'Udaipur',
    'Diu',
    'Bhuj',
    'Cuttack',
    'Jhansi',
    'Meerut',
    'Ranchi',
    'Kanpur',
    'Jammu',
    'Porbandar',
    'Darjeeling',
    'Siliguri',
    'Jalpaiguri',
    'Purulia',
    'Puri',
    'Deoghar',
    'Rourkela',
    'Sambalpur',
    'Vadodara',
    'Chennai',
    'Allahabad',
    'Kanyakumari',
    'Ooty',
    'Coimbatore',
    'Thanjavur',
    'Tirunelveli',
    'Chidambaram',
    'Vijayawada',
    'Rajahmundry',
    'Anantapur',
    'Kurnool',
    'Amravati',
    'Madurai',
    'Chittorgarh',
    'Bikaner',
    'Nagpur',
    'Jodhpur',
    'Chandigarh',
    'Thiruvananthapuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Mysore',
    'Hampi',
    'Chikmagalur',
    'Bijapur',
    'Pune',
    'Aurangabad',
    'Nashik',
    'Ratnagiri',
    'Kolhapur',
    'Varanasi',
    'Satara',
    'Indore',
    'Gwalior',
    'Ujjain',
    'Jabalpur',
    'Manali',
    'Kullu',
    'Palampur',
    'Nainital',
    'Rishikesh',
    'Ajmer',
    'Dehradun',
    'Mussoorie',
    'Almora',
    'Haridwar'
  ];
  final APIService apiService = APIService();
  String? _selectedCity;
  int _tripLength = 0;
  int _position = 0;
  String? _response;

  void _fetchItinerary() async {
    String city = _selectedCity!;
    int numDays = _tripLength;

    if (city.isEmpty || numDays <= 0) {
      setState(() {
        _response = 'Please provide a valid city and number of days.';
      });
      return;
    }

    try {
      final itinerary = await apiService.fetchItinerary(city, numDays);
      setState(() {
        _response = itinerary.toString();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItineraryDisplay(itinerary: itinerary),
        ),
      );
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_response'),
        ),
      );
    }
  }

  void _onSubmit() {
    if (_selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a city'),
        ),
      );
      return;
    }

    if (_tripLength == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a trip length'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Submitted successfully :${_selectedCity!} $_tripLength'),
      ),
    );

    _fetchItinerary();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenwidth,
        height: screenheight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(15, 164, 220, 1),
              Color.fromRGBO(68, 190, 231, 1)
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: screenwidth,
              height: 10,
              margin: EdgeInsets.only(
                  left: screenwidth * 0.053,
                  right: screenwidth * 0.053,
                  top: screenheight * 0.100,
                  bottom: screenheight * 0.080),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: screenwidth * 0.40,
                    height: screenheight * 0.01,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          _position >= 0 ? AppColors.primaryblue : Colors.white,
                      border: Border.all(
                        color: AppColors.primaryblue,
                        width: 1,
                      ),
                    ),
                  ),
                  Container(
                    width: screenwidth * 0.40,
                    height: screenheight * 0.01,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          _position == 1 ? AppColors.primaryblue : Colors.white,
                      border: Border.all(
                        color: AppColors.primaryblue,
                        width: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: screenwidth,
              height: screenheight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                  left: screenwidth * 0.053,
                  right: screenwidth * 0.053,
                  top: screenheight * 0.150,
                  bottom: screenheight * 0.080),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _position == 0
                      ? buidquestion1(screenwidth, screenheight)
                      : buidquestion2(screenwidth, screenheight),
                  buildButtons(screenwidth, screenheight, _position),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buidquestion1(double screenwidth, double screenheight) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenheight * 0.03),
          child: Text(
            'Where do you want to go?',
            style: GoogleFonts.poppins(
              fontSize: screenwidth * 0.06,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenheight * 0.03),
          child: DropdownButton<String>(
            menuWidth: screenwidth * 0.6,
            hint: Text(
              'Select Destination',
              style: GoogleFonts.poppins(
                fontSize: screenwidth * 0.04,
                fontWeight: FontWeight.normal,
              ),
            ),
            value: _selectedCity,
            items: _cities.map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(
                  city,
                  style: GoogleFonts.poppins(
                    fontSize: screenwidth * 0.04,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCity = newValue;
              });
              if (newValue != null) {
                // widget.onDestinationSelected(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buidquestion2(double screenwidth, double screenheight) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenheight * 0.03),
          child: Text(
            'How many days will your trip be?',
            style: GoogleFonts.poppins(
              fontSize: screenwidth * 0.05,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenheight * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.primaryblue,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: AppColors.primaryblue,
                    size: screenwidth * 0.07,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_tripLength > 1) _tripLength--;
                    });
                  },
                ),
              ),
              Text('$_tripLength',
                  style: TextStyle(fontSize: screenwidth * 0.06)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.primaryblue,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: AppColors.primaryblue,
                    size: screenwidth * 0.07,
                  ),
                  onPressed: () {
                    setState(() {
                      _tripLength++;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButtons(double screenWidth, double screenHeight, int position) {
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
              if (_position > 0) {
                setState(() {
                  _position--;
                });
              }
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
              if (_position < 1) {
                setState(() {
                  _position++;
                });
              } else {
                _onSubmit();
              }
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
                  position == 1 ? 'Submit' : 'Next',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
}
