import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/bloc/signup/signup_bloc.dart';
import 'package:tripeaze/src/bloc/signup/signup_state.dart';
import 'package:tripeaze/src/config/router.dart';

import '../../bloc/signup/signup_event.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pushNamed(
            context,
            Routes.main,
          );
        }
        if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignupLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: Image.asset(
                    'assets/images/signup.png',
                    width: width,
                    height: height * 0.3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.06, bottom: height * 0.023),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(35, 35, 35, 1),
                          fontSize: width * 0.085,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sign up to enjoy the features of Revolutie.',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(149, 149, 149, 1),
                          fontSize: width * 0.040,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  child: TextField(
                    controller: nameController,
                    //onChanged: provider.setName,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Colors.grey, fontSize: width * 0.045),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.040),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  child: TextField(
                    controller: emailController,
                    //onChanged: provider.setEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.grey, fontSize: width * 0.045),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.040),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  child: TextField(
                    controller: passwordController,
                    //onChanged: provider.setPassword,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Colors.grey, fontSize: width * 0.045),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * 0.05)),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: togglePassword,
                        child: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          size: width * 0.06,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.040),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<SignupBloc>(context).add(
                            SignupButtonPressed(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.9,
                          margin: EdgeInsets.only(top: height * 0.018),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * 0.05)),
                            color: const Color.fromRGBO(53, 122, 255, 1),
                            border: Border.all(
                              color: const Color.fromRGBO(230, 232, 231, 1),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
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
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: height * 0.010),
                      //   child: Text(
                      //     'or',
                      //     style: GoogleFonts.poppins(fontSize: width * 0.045),
                      //   ),
                      // ),
                      // Container(
                      //   height: height * 0.07,
                      //   width: width * 0.9,
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         BorderRadius.all(Radius.circular(width * 0.05)),
                      //     color: Colors.white,
                      //     border: Border.all(
                      //       color: const Color.fromRGBO(230, 232, 231, 1),
                      //       width: 1,
                      //     ),
                      //   ),
                      //   margin: EdgeInsets.symmetric(
                      //       vertical: height * 0.002, horizontal: width * 0.02),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset(
                      //         'assets/images/google_logo.png',
                      //         height: width * 0.08,
                      //       ),
                      //       SizedBox(width: width * 0.02),
                      //       Text(
                      //         'Continue with Google',
                      //         style: GoogleFonts.poppins(
                      //           color: Colors.black,
                      //           fontSize: width * 0.050,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.015),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(108, 108, 108, 1),
                                  fontSize: width * 0.040,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, Routes.signin);
                                  },
                                text: 'Login here',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(53, 122, 255, 1),
                                  fontSize: width * 0.040,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
