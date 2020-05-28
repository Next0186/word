import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/common/shared.dart';
import 'package:word/common/theme.dart';
import 'package:word/router/routes.dart';
import 'package:word/store/provider.dart';
// import 'package:word/views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map userInfo = await Shared.getMap('userInfo');
  if (Platform.isAndroid) {
    // 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp(userInfo));
}

class MyApp extends StatelessWidget {
  final Map userInfo;
  const MyApp(this.userInfo, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Store.init(
      child: MaterialApp(
        initialRoute: userInfo != null ? 'homePage' : 'login',
        navigatorKey: NavKey.navKey,
        onGenerateRoute: routeGenerator,
        theme: theme,
        // home: HomePage()
      ),
      userInfo: userInfo
    );
  }
}
