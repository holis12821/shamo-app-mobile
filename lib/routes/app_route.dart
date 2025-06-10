import 'package:shamoapps/presentation/screens/home_screen/home_screen.dart';
import 'package:shamoapps/presentation/screens/sign_in_screen/sign_in_screen.dart';
import 'package:shamoapps/presentation/screens/sign_up_screen/sign_up_screen.dart';

class AppRoute {
  static var routeHandler = {
    '/': (context) => const SignInScreen(),
    '/sign-up': (context) => const SignUpScreen(),
    '/home': (context) => const HomeScreen(),
  };
}
