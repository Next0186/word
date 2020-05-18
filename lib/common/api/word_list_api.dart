// import 'package:dio/dio.dart';
import 'package:word/common/api/client.dart';

class WordListApi extends ApiClient {
  
  /// 获取单词列表
  Future getWordList() {
    return request('http://yapi.maxrocky.com/mock/47/word/wordList');
  }
  
  /// 查找单个单词
  Future findWord(String word) {
    return request('/auth/translate?word=$word');
  }
}

final wordListApi = WordListApi();