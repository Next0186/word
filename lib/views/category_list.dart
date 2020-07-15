import 'dart:async';
import 'package:date_time_format/date_time_format.dart';
import 'package:word/common/api/word_list_api.dart';
import 'package:word/common/icon.dart';
import 'package:word/components/word_detail/add_category.dart';
import 'package:word/store/provider.dart';
import 'package:word/components/word.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/store/module/word_list_store.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<CategoryList> {

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

  _addCategory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCategory(
          submit: (name, description) async {
            try {
              var res = await wordListApi.createCategory(name, description);
              Navigator.pop(context);
              getDate();
              print(['object', res]);
            } catch (e) {
              print(['object', e]);
            }
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<WordListStore>(builder: (context, store, child) {
      var category = store.category;
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addCategory();
          },
          backgroundColor: MyColor.primaryColor,
          child: IconView(IconFont.edit, color: Colors.white, size: 16),
        ),
        body: category != null ? SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: category.map((item) {
              var updateTime = DateTimeFormat.format(DateTime.parse(item.updateAt), format: 'Y-m-d h:i:s');
              return View(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5, color: MyColor.borderColor))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(child: TextView(item.title, size: 16, weight: FontWeight.w500,),),
                        TextView(updateTime, color: MyColor.textColorSecondary, size: 12,),
                      ]
                    ),
                    SizedBox(height: 2,),
                    item.subTitle  == '' ? View() : TextView(item.subTitle, color: MyColor.textColorSecondary,),
                    Wrap(
                      spacing: 2,
                      children: item.words.map((e) => View(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.backgroundColor
                        ),
                        child: TextView(e.word, size: 16, color: MyColor.textColorSecondary,),
                      )).toList()
                    )
                    // TextView(words.join(' ')),
                    // TextView('描述'),
                  ]
                ),
              );
            }).toList()
          )
        ) : View(
          alignment: Alignment.center,
          child: TextView('数据加载中...'),
        )
      );
    });
  }
}