import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';

class AddCategory extends StatefulWidget {
  final Function(String name, String description) submit;
  AddCategory({Key key, this.submit}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextView('添加单词分类', textAlign: TextAlign.center,),
      content: View(
        height: 120,
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            View(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.backgroundColor
              ),
              child: TextField(
                controller: _name,
                maxLength: 10,
                cursorWidth: 1,
                style: TextStyle(color: MyColor.textColor),
                decoration: InputDecoration(
                  counterText: '',
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: '请输入分类名称'
                ),
              )
            ),
            SizedBox(height: 10,),
            View(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.backgroundColor
              ),
              child: TextField(
                cursorWidth: 1,
                maxLength: 20,
                controller: _description,
                style: TextStyle(color: MyColor.textColor),
                decoration: InputDecoration(
                  counterText: '',
                  hintStyle: TextStyle(fontSize: 14),
                  hintText: '请输入分类描叙'
                ),
              )
            )
          ]
        ),
      ),
      actions: [
        FlatButton(child: Text("取消"), onPressed: () => Navigator.of(context).pop()),
        FlatButton(child: Text("确定"), onPressed: () async {
          widget.submit(_name.text, _description.text);
          // try {
          //   await wordApi.collectWord(acItem.sId, widget.word);
          //   Fluttertoast.showToast(msg: '收藏成功');
          //   widget.callBack();
          //   Navigator.of(context).pop();
          // } catch (e) {
          //   print(['收藏失败', e]);
          // }
        }),
      ]
    );
  }
}
