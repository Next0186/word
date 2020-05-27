import 'package:flutter/widgets.dart';
import 'package:word/common/shared.dart';
import 'package:word/models/user_info_model.dart';

class UserInfoStore extends ChangeNotifier{
  UserInfoModel userInfo;

  setUserInfo(json) {
    userInfo = UserInfoModel.fromJson(json);
    notifyListeners();
    Shared.setItem('userInfo', json.toString());
  }
}