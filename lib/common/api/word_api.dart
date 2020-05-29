import 'client.dart';

class WordApi extends ApiClient {
  // /auth/translate
  Future getWord(String word) {
    return request('/auth/translate?word=$word');
  }

  /// 获取单词描叙
  Future getWordDesc(String word, [int c = 10, int p = 1]) {
    return request('/auth/get/word/desc?c=$c&p=$p', { 'word': word });
  }
  
}
final wordApi = WordApi();