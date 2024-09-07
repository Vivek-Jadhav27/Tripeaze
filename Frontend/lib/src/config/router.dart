import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tripeaze/src/bloc/place/place_bloc.dart';
import 'package:tripeaze/src/bloc/profile/profile_bloc.dart';
import 'package:tripeaze/src/presentation/auth/forgot_password.dart';
import 'package:tripeaze/src/presentation/auth/otp_page.dart';
// import 'package:tripeaze/src/presentation/auth/provider/signin_provider.dart';
// import 'package:tripeaze/src/presentation/auth/provider/signup_provider.dart';
import 'package:tripeaze/src/presentation/auth/signin_page.dart';
import 'package:tripeaze/src/presentation/auth/signup_page.dart';
// import 'package:tripeaze/src/presentation/home/details_page.dart';
import 'package:tripeaze/src/presentation/home/main_page.dart';
import 'package:tripeaze/src/presentation/home/search_page.dart';
import 'package:tripeaze/src/presentation/menu/customer_support_page.dart';
import 'package:tripeaze/src/presentation/menu/policy_page.dart';
import 'package:tripeaze/src/presentation/menu/terms_conditions_page.dart';
import 'package:tripeaze/src/presentation/onboarding/onboarding_page.dart';
import 'package:tripeaze/src/presentation/spalshscreen/splash_screen.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/signin/signin_bloc.dart';
import '../bloc/signup/signup_bloc.dart';
import '../presentation/auth/provider/forgot_password_provider.dart';
import '../presentation/home/home_page.dart';
import '../presentation/home/wishlist_page.dart';

class AppRouter {
  static List<AppRoute> routes() => [
        AppRoute(
          route: Routes.onboarding,
          view: const OnboardingPage(),
        ),
        AppRoute(
          route: Routes.signin,
          view: const SignInPage(),
        ),
        AppRoute(
          route: Routes.signup,
          view: const SignupPage(),
        ),
        // AppRoute(
        //   route: Routes.details,
        //   view: const DetailsPage(),
        // ),
        AppRoute(
          route: Routes.policy,
          view: const PrivacyPolicyPage(),
        ),
        AppRoute(
          route: Routes.terms,
          view: const TermsPage(),
        ),
        AppRoute(
          route: Routes.forgotpasssword,
          view: const ForgotPassword(),
        ),
        AppRoute(
          route: Routes.otp,
          view: const OtpPage(),
        ),
        AppRoute(
          route: Routes.main,
          view: const MainPage(),
        ),
        AppRoute(
          route: Routes.wishlist,
          view: const WishlistPage(),
        ),
        AppRoute(
          route: Routes.customersupport,
          view: const CustomerSupport(),
        ),
        // AppRoute(
        //   route: Routes.details,
        //   view: const DetailsPage(),
        // ),
        AppRoute(
          route: Routes.search,
          view: const SearchPage(),
        ),
        AppRoute(
          route: Routes.splash,
          view: const SplashScreen(),
        ),
      ];

  static List allproviders() => [
        BlocProvider(create: (context) => SigninBloc()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => PlaceBloc()),
        // ChangeNotifierProvider(create: (context) => SigninProvider()),
        // ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
      ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => routes()
          .firstWhere(
            (element) => element.route == settings.name,
            orElse: () => AppRoute(
              route: Routes.home,
              view: const HomePage(),
            ),
          )
          .view,
    );
  }
}

class AppRoute {
  String route;
  Widget view;
  AppRoute({
    required this.route,
    required this.view,
  });
}

class Routes {
  static const String splash = '/splash';
  static const String main = '/';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String details = '/details';
  static const String settings = '/settings';
  static const String policy = '/policy';
  static const String terms = '/terms';
  static const String profile = '/profile';
  static const String otp = '/otp';
  static const String wishlist = '/wishlist';
  static const String customersupport = '/customersupport';
  static const String forgotpasssword = '/forgotpasssword';
  static const String search = '/search';
}
