import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';
import 'package:word/models/user_info_model.dart';
import 'package:word/store/module/user_info_store.dart';
import 'package:word/store/provider.dart';

class SentencesCategoryDialog extends StatefulWidget {
  final String sentence;
  final Function callBack;
  final List<String> words;
  SentencesCategoryDialog(this.words, this.sentence, {Key key, this.callBack}) : super(key: key);

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<SentencesCategoryDialog> {
  SentenceGroup acItem;
  List<SentenceGroup> category;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var _category = Store.value<UserInfoStore>(context).userInfo?.sentenceGroup;
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
              return RadioListTile<SentenceGroup>(
                value: item,
                groupValue: acItem,
                selected: acItem == item,
                title: TextView(item.title),
                activeColor: MyColor.primaryColor,
                subtitle: item.subTitle.isNotEmpty ? TextView(item.subTitle) : null,
                onChanged: (value) {
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
            await wordApi.collectSentences(acItem.sId, widget.words, widget.sentence);
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