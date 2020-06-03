import 'package:dio/dio.dart';

import 'client.dart';

class WordApi extends ApiClient {
  // /auth/translate
  Future getWord(String word) {
    return request('/auth/translate?word=$word');
  }

  // /// 获取单词描叙
  // Future getWordDesc(String word, [int c = 10, int p = 1]) {
  //   return request('/auth/get/word/desc?c=$c&p=$p', { 'word': word });
  // }

  /// 获取单词笔记
  Future addWordDesc(String word, String desc) {
    return request('/auth/add/word/desc', { 'word': word, 'desc': desc });
  }

  /// 删除单词笔记
  Future deleteWordDesc(String descId) {
    return request('/auth/delete/word/desc?id=$descId', null, Options(method: 'DELETE'));
  }

  /// 修改单词笔记
  Future updateWordDesc(String id, String desc) {
    return request('/auth/update/word/desc', {'id': id, 'desc': desc}, Options(method: 'PUT'));
  }
  /// 收藏单词
  Future collectWord(String id, String word) {
    return request('/auth/add/collect', {'categoryId': id, 'word': word});
  }

  /// 删除收藏单词
  Future removeCollectWord(String word, String categoryId) {
    return request('/auth/remove/collect', {'word': word, 'categoryId': categoryId}, Options(method: 'DELETE'));
  }

  /// 添加句子
  Future addSentences(String sentence, List<String> words) {
    return request('/auth/sentence', {'sentence': sentence, 'words': words});
  }

  /// 查找句子的单词
  Future findWords(List<String> words) {
    return request('/auth/find/words', {'words': words});
  }

  
}
final wordApi = WordApi();