import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:town/common/nav_key.dart';
// import 'package:town/store/module/market_store.dart';
// import 'package:town/store/module/mine_store.dart';
// import 'package:town/store/module/town_store.dart';
// import 'package:town/store/module/news_store.dart';
// import 'package:town/store/module/home_store.dart';
// import 'package:town/store/module/user_store.dart';
// import 'package:town/store/module/topic_store.dart';
// import 'package:town/store/module/circle_store.dart';
// import 'package:town/store/module/company_store.dart';
// import 'package:town/store/module/message_store.dart';
// import 'package:town/store/module/mini_app_store.dart';
// import 'package:town/store/module/my_order_store.dart';
// import 'package:town/store/module/my_reply_store.dart';
// import 'package:town/store/module/activeity_store.dart';
// import 'package:town/store/module/my_publish_store.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/store/module/word_list_store.dart';

class Store {

  //  我们将会在main.dart中runAPP实例化init
  static init({Widget child, SharedPreferences prefs}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordListStore()),
        // ChangeNotifierProvider(create: (_) => NewsStore()),
        // ChangeNotifierProvider(create: (_) => UserStore()),
        // ChangeNotifierProvider(create: (_) => MineStore()),
        // ChangeNotifierProvider(create: (_) => TopicStore()),
        // ChangeNotifierProvider(create: (_) => MarketStore()),
        // ChangeNotifierProvider(create: (_) => CircleStore()),
        // ChangeNotifierProvider(create: (_) => CompanyStore()),
        // ChangeNotifierProvider(create: (_) => MiniAppStore()),
        // ChangeNotifierProvider(create: (_) => MessageStore()),
        // ChangeNotifierProvider(create: (_) => MyReplyStore()),
        // ChangeNotifierProvider(create: (_) => MyOrderStore()),
        // ChangeNotifierProvider(create: (_) => ActivityStore()),
        // ChangeNotifierProvider(create: (_) => MyPublishStore()),
        // ChangeNotifierProvider(create: (_) => TownStore(townId, terminalById)),
        // ChangeNotifierProvider(create: (_) => TokenStore(tokenInfo))
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