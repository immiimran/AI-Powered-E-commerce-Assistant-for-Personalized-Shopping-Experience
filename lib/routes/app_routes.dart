import 'package:get/get.dart';
import '../views/splash_screen.dart';
import '../views/login_screen.dart';
import '../views/register_screen.dart';
import '../views/home_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: home, page: () => HomeScreen()),
  ];
}
