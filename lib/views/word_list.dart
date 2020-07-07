import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';
import 'package:word/models/user_info_model.dart';
import 'package:word/store/module/word_list_store.dart';
import 'package:word/store/provider.dart';

class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {

  @override
  void initState() {
    super.initState();
    getDate();
  }

  Future<void> getDate() async {
    try {
      var res = await wordApi.getCategoryList();
      Store.value<WordListStore>(context).setCategory(res['data']);
      print(['object', Store.value<WordListStore>(context).category]);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<WordListStore>(builder: (context, store, child) {
      var category = store.category;
      return category != null ? SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: category.map((item) => View(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.5, color: MyColor.borderColor))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextView(item.title, size: 16, weight: FontWeight.w500,),
                
                // TextView('描述'),
                TextView(item.subTitle == '' ? item.updateAt : item.subTitle),
              ]
            ),
          )).toList()
        )
      ) : View(
        alignment: Alignment.center,
        child: TextView('数据加载中...'),
      );
    });
  }
}