import 'package:dio/dio.dart';
import 'package:word/store/provider.dart';
import 'package:word/common/api/user_api.dart';
import 'package:word/common/comfig/packages.dart';
import 'package:word/store/module/user_info_store.dart';
class Http {
  Http._();
  static Future loading;

  static Dio request = Dio(BaseOptions(
    baseUrl: DioConfig.baseUrl,
    connectTimeout: DioConfig.connectTimeout
  ));


  // 刷新 token
  static Future refreshToken() {
    if (loading == null) {
      var rfToken = Store.getValue<UserInfoStore>().userInfo.rfToken;
      loading = userApi.refreshToken(rfToken).then((val){
        loading = null;
        
        print(['刷新token', val]);
        return val;
      }).catchError((onError) {
        loading = null;
        throw Exception(onError);
      });
    }
    return loading;
  }
}
