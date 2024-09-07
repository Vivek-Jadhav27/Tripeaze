import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripeaze/src/bloc/signin/signin_bloc.dart';
import 'package:tripeaze/src/config/router.dart';

import '../../bloc/signin/signin_event.dart';
import '../../bloc/signin/signin_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isvisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePassword() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<SigninBloc, SigninState>(
      builder: (BuildContext context, SigninState state) {
        if (state is SigninLoading) {
          return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()));
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
                    'assets/images/signin.png',
                    width: width,
                    height: height * 0.3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.06, bottom: height * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign in',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(35, 35, 35, 1),
                          fontSize: width * 0.085,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Please login to continue to your account.',
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03, vertical: height * 0.01),
                  child: TextField(
                    obscureText: !isvisible,
                    controller: passwordController,
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
                          isvisible ? Icons.visibility : Icons.visibility_off,
                          size: width * 0.06,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                ),
                
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: width * 0.05, vertical: height * 0.015),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       GestureDetector(
                //         onTap: () => Navigator.pushNamed(
                //             context, Routes.forgotpasssword),
                //         child: Text(
                //           'Forgot Password?',
                //           style: GoogleFonts.poppins(
                //             fontSize: width * 0.04,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<SigninBloc>(context).add(
                            SigninButtonPressed(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        },
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.9,
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
                              'Sign in',
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
                      //   padding: EdgeInsets.symmetric(vertical: height * 0.015),
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
                      //         'Sign in with Google',
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
                                text: 'Need an account? ',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(108, 108, 108, 1),
                                  fontSize: width * 0.040,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, Routes.signup);
                                  },
                                text: 'Create here',
                                style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(0, 122, 255, 1),
                                  fontSize: width * 0.040,
                                  fontWeight: FontWeight.bold,
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
      listener: (BuildContext context, SigninState state) {
        if (state is SigninSuccess) {
          Navigator.pushNamed(context, Routes.main);
        } else if (state is SigninError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
    );
  }
}
