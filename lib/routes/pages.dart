import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_20/pages/DaftarProduk.dart';
import 'package:pas1_mobile_11pplg1_20/pages/favorite_page.dart';
import 'package:pas1_mobile_11pplg1_20/pages/login_page.dart';
import 'package:pas1_mobile_11pplg1_20/pages/profile_page.dart';
import 'package:pas1_mobile_11pplg1_20/pages/register_page.dart';
import 'package:pas1_mobile_11pplg1_20/pages/splashscreen_page.dart';
import 'package:pas1_mobile_11pplg1_20/navbar/navbar.dart';
import 'routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashscreenPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.productDetail, page: () => const DaftarprodukAPI()),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoutes.favorites, page: () => const FavoritePage()),
    GetPage(name: AppRoutes.navbar, page: () => const Navbar()),
  ];
}
