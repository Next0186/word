import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:word/models/word_list_model.dart';
import 'package:word/views/home.dart';
import 'package:word/views/word_detail.dart';

final Map<String, WidgetBuilder> routesConfig = {
  /// 首页
  'index': (context) => HomePage(),

  /// 单词详情
  'wordDetail': (context) {
    Words detail = ModalRoute.of(context).settings.arguments;
    return WordDetail(item: detail);
  },

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
