// import 'package:dio/dio.dart';
import 'package:word/common/api/client.dart';

class LoginApi extends ApiClient {

  /// 登录
  Future login(String mobile, String password) {
    return request('https://www.room-li.com:8080/api/login', { mobile, password });
  }
}

final wordListApi = LoginApi();