// import 'package:dio/dio.dart';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:word/common/api/client.dart';

class UserApi extends ApiClient {

  /// 登录
  Future login(String userName, String password) {
    return request('/api/login', { 'userName': userName, 'password': password });
  }

  /// 获取邮件验证码
  Future getCode(String email) {
    return request('/api/send/email', { 'email': email });
  }

  /// 注册
  Future signup({ String email, String password, String userName, String code }) {
    return request('/api/create/user', { 'email': email, 'password': password, 'userName': userName, 'code': code  });
  }

  /// 找回密码
  Future findPassword(String email, String password, String code) {
    return request('/api/find/password', { 'email': email, 'password': password, 'code': code  });
  }

  /// 刷新token
  Future refreshToken(String rfToken) {
    return request('/api/refresh/token', null, Options(headers: { 'refresh-token': rfToken }, method: 'POST'));
  }
}
// http://192.168.88.107:7001/api/ refresh /token
// http://192.168.88.107:7001​/api​/ refresh​ /token

final userApi = UserApi();