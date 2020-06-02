import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';
import 'package:word/models/user_info_model.dart';
import 'package:word/store/module/user_info_store.dart';
import 'package:word/store/provider.dart';

class CategoryDialog extends StatefulWidget {
  final String word;
  final Function callBack;
  CategoryDialog(this.word, {Key key, this.callBack}) : super(key: key);

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  Category acItem;
  List<Category> category;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var _category = Store.value<UserInfoStore>(context).userInfo?.category;
    setState(() {
      category = _category;
      acItem = _category[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextView('选择分类', textAlign: TextAlign.center,),
      content: View(
        height: 200,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
            children: category != null ? category.map((item) {
              return RadioListTile<Category>(
                value: item,
                groupValue: acItem,
                selected: acItem == item,
                title: TextView(item.title),
                activeColor: MyColor.primaryColor,
                subtitle: item.subTitle.isNotEmpty ? TextView(item.subTitle) : null,
                onChanged: (value) {
                  print(['object', acItem, value.sId]);
                  setState(() => acItem = value);
                },
              );
            }).toList() : []
          ),
        ),
      ),
      actions: [
        FlatButton(child: Text("确定"), onPressed: () async {
          try {
            await wordApi.collectWord(acItem.sId, widget.word);
            Fluttertoast.showToast(msg: '收藏成功');
            widget.callBack();
            Navigator.of(context).pop();
          } catch (e) {
            print(['收藏失败', e]);
          }
        }),
        FlatButton(child: Text("取消"), onPressed: () => Navigator.of(context).pop())
      ]
    );
  }
}