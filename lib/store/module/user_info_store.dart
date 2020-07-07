import 'package:flutter/widgets.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/common/shared.dart';
import 'package:word/models/user_info_model.dart';
import 'package:word/store/module/word_list_store.dart';
import 'package:word/store/provider.dart';

class UserInfoStore with ChangeNotifier{
  UserInfoModel userInfo;
  UserInfoStore(Map userInfo) {
    setUserInfo(userInfo);
  }

  setUserInfo(json) {
    if (json == null) return;
    userInfo = UserInfoModel.fromJson(json);
    // Store.getValue<WordListStore>().setCategory(json['category']);
    notifyListeners();
    Shared.setMap('userInfo', json);
  }
  setToken(token) {
    userInfo.token = token['token'];
    userInfo.rfToken = token['rfToken'];
    Shared.setMap('userInfo', userInfo.toJson());
  }

  resetUserInfo() {
    userInfo = null;
    notifyListeners();
    Shared.removeItem('userInfo');
    NavKey.navKey.currentState.pushNamedAndRemoveUntil('login', (route) => false);
  }
}