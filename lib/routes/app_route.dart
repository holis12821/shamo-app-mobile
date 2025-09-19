import 'package:shamoapps/presentation/screens/detail_chat_screen/view/detail_chat_screen.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:shamoapps/presentation/screens/main_screen/view/main_screen.dart';
import 'package:shamoapps/presentation/screens/product_detail_screen/view/product_detail_screen.dart';
import 'package:shamoapps/presentation/screens/sign_in_screen/view/sign_in_screen.dart';
import 'package:shamoapps/presentation/screens/sign_up_screen/view/sign_up_screen.dart';

class AppRoute {
  static var routeHandler = {
    '/': (context) => const SignInScreen(),
    '/sign-up': (context) => const SignUpScreen(),
    '/home': (context) => const MainScreen(),
    '/detail-chat': (context) => const DetailChatScreen(),
    '/edit-profile': (context) => const EditProfileScreen(),
    '/product': (context) => ProductDetailScreen(),
  };
}
