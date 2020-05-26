import 'package:flutter/widgets.dart';
import 'package:word/views/home.dart';
import 'package:flutter/material.dart';
import 'package:word/views/login.dart';
import 'package:word/views/signup.dart';
import 'package:word/views/word_detail.dart';
import 'package:word/models/word_list_model.dart';

final Map<String, WidgetBuilder> routesConfig = {
  /// 首页
  'index': (context) => HomePage(),

  /// 单词详情
  'wordDetail': (context) {
    Words detail = ModalRoute.of(context).settings.arguments;
    return WordDetail(item: detail);
  },

  /// 登录
  'login': (context) => Login(),

  /// 注册
  'signup': (context) => Signup(),

  // // 注册
  // 'register': (context) {
  //   return LoginTemp(mode: LoginTempMode.register);
  // }

};

// 页面跳转拦截
Route routeGenerator(RouteSettings settings) {
  String routerName = settings.name;
  WidgetBuilder builder = routesConfig[routerName];

  return MaterialPageRoute(builder: builder, settings: settings);
}
