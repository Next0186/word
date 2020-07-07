import 'package:flutter/widgets.dart';
import 'package:word/common/api/word_list_api.dart';
import 'package:word/models/user_info_model.dart';
import 'package:word/models/word_list_model.dart';

class WordListStore with ChangeNotifier {
  WordListModel wordList;
  List<Category> category;

  Future getData() async {
    try {
      final res = await wordListApi.getWordList();
      wordList = WordListModel.fromJson(res['data']);
      notifyListeners();
    } catch (e) {
      print(['获取列表失败', e]);
    }
  }
  
  /// 添加收藏单词列表
  setCategory(List list) {
    if (list.isEmpty) return;
    category = list.map((e) => new Category.fromJson(e)).toList();
    notifyListeners();
  }

}