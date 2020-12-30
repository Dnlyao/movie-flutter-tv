import 'package:flutter/cupertino.dart';

import '../pages/nav_bar.dart';
import '../pages/player.dart';

class Routing {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Map<String, WidgetBuilder> list = {
    '/': (_) => NavBar(), // 导航页
    '/play': (_) => Player(), // 播放
    // '/login': (_) => Login(), // 登录
  };
  static String defaultPage = '/';
}
