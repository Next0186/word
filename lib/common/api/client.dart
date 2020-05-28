import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:word/common/api/dio.dart';
import 'package:word/store/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/store/module/user_info_store.dart';

class ApiClient {
  RegExp pathAuth = RegExp('^/auth');

  Future request(path, [dynamic params, Options options, ApiClientConfig config]) async {
    Response res;
    if (config == null) config = ApiClientConfig();
    final _options = options ?? Options();
    print(['pathAuth.hasMatch(path)', pathAuth.hasMatch(path)]);
    if (pathAuth.hasMatch(path)) {
      _options.headers['token'] = Store.getValue<UserInfoStore>().userInfo.token;
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
    if (code == 'AUTH_0037') {
      // TokenInfo.resetUserInfo();
      Fluttertoast.showToast(msg: data['msg'] ?? '用户系统异常', gravity: ToastGravity.BOTTOM);
      return Future.error(data);
      // throw Exception(data);
    }

    if (code == '0' || config.skipCode) {
      return data;
    } else {
      if (config.showToast) Fluttertoast.showToast(msg: data['error'] ?? '接口数据异常');
      return Future.error(data);
    }

    // if (refreshCode.contains(code)) {
    //   try {
    //     /// 刷新token并重新请求该接口
    //     var token = await Http.refreshToken();
    //     print(['刷新token', token]);
    //     TokenInfo.setToken(token['data']);
    //     var params =  res.request;
    //     return await request(params.path, params.data, params);
    //   } catch (e) {
    //     print(['刷新token失败', e]);
    //     TokenInfo.resetUserInfo();
    //     return Future.error(e);
    //     // throw Exception(e);
    //   }
    // } else {
    //   if (code == '0' || config.skipCode) {
    //     return data;
    //   } else {
    //     if (config.showToast) Fluttertoast.showToast(msg: data['msg'] ?? '接口数据异常');
    //     return Future.error(data);
    //   }
    // }
  }
}

class ApiClientConfig {
  final bool noToken;
  final bool skipCode;
  final bool showToast;
  ApiClientConfig({this.skipCode = false, this.noToken = false, this.showToast = true});
}
