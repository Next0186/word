import 'client.dart';

class WordApi extends ApiClient {
  // /auth/translate
  Future getWord(String word) {
    return request('/auth/translate?word=$word');
  }
  // Future getWordList() {
  //   return request('http://yapi.maxrocky.com/mock/47/word/wordList');
  // }
  
}
final wordApi = WordApi();