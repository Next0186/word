import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:word/views/home.dart';
import 'package:flutter/material.dart';
import 'package:word/views/home_page.dart';
import 'package:word/views/login.dart';
import 'package:word/views/retrieve.dart';
import 'package:word/views/sentences.dart';
import 'package:word/views/signup.dart';
import 'package:word/views/web_view.dart';
import 'package:word/views/word_detail.dart';

final Map<String, WidgetBuilder> routesConfig = {
  'homePage': (context) => HomePage(),

  /// 首页
  'home': (context) => Home(),

  /// 单词详情
  'wordDetail': (context) {
    String word = ModalRoute.of(context).settings.arguments;
    return WordDetail(word);
  },

  /// 登录
  'login': (context) => Login(),

  /// 注册
  'signup': (context) => Signup(),

  /// 找回密码 或 修改密码
  'retrieve': (context) {
    final String title = ModalRoute.of(context).settings.arguments;
    return Retrieve(title: title);
  },

  /// webview
  'webView': (context) {
    final String url = ModalRoute.of(context).settings.arguments;
    return WebViewPage(url);
  },

  // 句子页面
  'sentences': (context) {
    String sentences = ModalRoute.of(context).settings.arguments;
    return Sentences(sentences);
  }

};

// 页面跳转拦截
Route routeGenerator(RouteSettings settings) {
  String routerName = settings.name;
  WidgetBuilder builder = routesConfig[routerName];

  return CupertinoPageRoute(builder: builder, settings: settings);
}
