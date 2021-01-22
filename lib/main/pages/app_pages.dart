import 'package:get/get.dart';

import '../../ui/pages/feed/feed_page.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/pages/news/news_page.dart';
import '../../ui/pages/splash/splash_page.dart';
import '../../ui/pages/welcome/welcome_page.dart';
import '../bindinds/login_bindind.dart';
import '../bindinds/splash_binding.dart';

abstract class AppPages {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const feed = '/feed';
  static const news = '/news';

  static final pages = [
    GetPage(
      name: splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: welcome,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: feed,
      page: () => FeedPage(),
    ),
    GetPage(
      name: news,
      page: () => NewsPage(),
    ),
  ];
}
