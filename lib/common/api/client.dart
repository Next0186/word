import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:word/common/api/dio.dart';
import 'package:word/store/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/store/module/user_info_store.dart';

class ApiClient {
  RegExp pathAuth = RegExp('^/auth');

  Future request(String path, [dynamic params, Options options]) async {
    Response res;
    final _options = options ?? Options();
    if (pathAuth.hasMatch(path)) {
      _options.headers['token'] = Store.getValue<UserInfoStore>().userInfo.token;
    }

    if (RegExp('^/api/refresh/token').hasMatch(path)) {
      print(['object', path]);
    }

    try {
      if (params == null && options == null) {
        res = await Http.request.get(path, options: _options);
      } else if (params != null && options == null) {
        res = await Http.request.post(path, data: params, options: _options);
      } else {
        res = await Http.request.request(path, data: params, options: _options);
      }
    } catch (e) {
      print(['请求异常', e]);
      Fluttertoast.showToast(msg: '请求异常');
      return Future.error(e);
    }

    if (res == null) throw Exception('接口返回值为空');

    var data = res.data;
    if (data is String) data = json.decode(data);
    final String code = data['code'].toString();

    if (code == '0') {
      return data;
    } else if (code == '434') { /// token 无效
      try {
        /// 刷新token并重新请求该接口
        var token = await Http.refreshToken();
        Store.getValue<UserInfoStore>().setToken(token['data']);
        var params =  res.request;
        return await request(params.path, params.data, params);
      } catch (e) {
        print(['刷新token失败', e]);
        return Future.error(e);
      }
    } else if (code == '435') { /// refresh token 无效
      Fluttertoast.showToast(msg: data['error'] ?? '登录失效');
      Store.getValue<UserInfoStore>().resetUserInfo();
      return Future.error(data);
    } else {
      Fluttertoast.showToast(msg: data['error'] ?? '接口数据异常');
      return Future.error(data);
    }
  }
}
