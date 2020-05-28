import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/store/module/user_info_store.dart';
import 'package:word/store/module/word_list_store.dart';

class Store {

  //  我们将会在main.dart中runAPP实例化init
  static init({Widget child, Map userInfo}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfoStore(userInfo), lazy: false),
        ChangeNotifierProvider(create: (_) => WordListStore()),
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  // 无 context 获取值
  static T getValue<T> ({bool listen = false}) {
    return Provider.of(NavKey.navKey.currentContext, listen: listen);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({Function(BuildContext, T, Widget) builder, Widget child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}