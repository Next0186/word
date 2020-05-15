// import 'package:dio/dio.dart';
import 'package:word/common/api/client.dart';

class WordListApi extends ApiClient {
  
  /// 获取单词列表
  Future getWordList() {
    return request('/wordList');
  }
}

final wordListApi = WordListApi();