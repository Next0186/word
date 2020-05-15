import 'package:flutter/widgets.dart';
import 'package:word/common/api/word_list_api.dart';
import 'package:word/models/word_list_model.dart';

class WordListStore with ChangeNotifier {
  WordListModel wordList;

  Future getData() async {
    try {
      final res = await wordListApi.getWordList();
      wordList = WordListModel.fromJson(res['data']);
      notifyListeners();
    } catch (e) {
      print(['获取列表失败', e]);
    }
  }
}