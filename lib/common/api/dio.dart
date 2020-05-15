import 'package:dio/dio.dart';
// import 'package:town/common/api/user_api.dart';
// import 'package:town/common/comfig/base_config.dart';
import 'package:word/common/comfig/packages.dart';
// import 'package:town/components/town.dart';
class Http {
  Http._();
  static Future loading;

  static Dio request = Dio(BaseOptions(
    baseUrl: DioConfig.baseUrl,
    connectTimeout: DioConfig.connectTimeout
  ));


  // 刷新 token
  // static Future refreshToken() {
  //   if (loading == null) {
  //     loading = userApi.refreshToken(1).then((val){
  //       loading = null;
  //       return val;
  //     }).catchError((onError) {
  //       loading = null;
  //       throw Exception(onError);
  //     });
  //   }
  //   return loading;
  // }
}
