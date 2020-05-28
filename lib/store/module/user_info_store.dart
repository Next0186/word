import 'package:flutter/widgets.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/common/shared.dart';
import 'package:word/models/user_info_model.dart';

class UserInfoStore with ChangeNotifier{
  UserInfoModel userInfo;
  UserInfoStore(Map userInfo) {
    setUserInfo(userInfo);
  }

  setUserInfo(json) {
    if (json == null) return;
    userInfo = UserInfoModel.fromJson(json);
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