import 'package:flutter/widgets.dart';
import 'package:word/common/shared.dart';
import 'package:word/models/user_info_model.dart';

class UserInfoStore with ChangeNotifier{
  UserInfoStore(Map userInfo) {
    setUserInfo(userInfo);
  }

  UserInfoModel userInfo;

  setUserInfo(json) {
    if (json == null) return;
    userInfo = UserInfoModel.fromJson(json);
    notifyListeners();
    Shared.setMap('userInfo', json);
  }
}