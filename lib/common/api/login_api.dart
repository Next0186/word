// import 'package:dio/dio.dart';
import 'package:word/common/api/client.dart';

class LoginApi extends ApiClient {

  /// 登录
  Future login(String userName, String password) {
    return request('https://www.room-li.com:8080/api/login', { 'userName': userName, 'password': password });
  }
}

final wordListApi = LoginApi();