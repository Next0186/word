import 'package:word/common/icon.dart';
import 'package:word/common/nav_key.dart';
import 'package:word/store/provider.dart';
import 'package:word/components/word.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/store/module/word_list_store.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  // List<Widget> _buildWrap(List<Words> words) {
  //   return words
  //       .map((item) => GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pushNamed('wordDetail', arguments: item);
  //           },
  //           child: Chip(
  //             avatar: ImageBuild(
  //                 url: item.avatar, borderRadius: BorderRadius.circular(20)),
  //             label: TextView(item.word),
  //           )))
  //       .toList();
  // }

  // Widget _buildItem(DataList item) {
  //   // print(await "example".translate(to: 'pt'));
  //   return View(
  //     padding: EdgeInsets.symmetric(vertical: 10),
  //     decoration: BoxDecoration(
  //         border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
  //     child: Column(
  //       children: <Widget>[
  //         TextView(
  //           item.sentence,
  //           size: 16,
  //           margin: EdgeInsets.only(bottom: 2),
  //         ),
  //         TextView(
  //           '翻译：\n${item.translate}',
  //           size: 16,
  //         ),
  //         Wrap(
  //           spacing: 8.0, // 主轴(水平)方向间距
  //           runSpacing: 4.0, // 纵轴（垂直）方向间距
  //           alignment: WrapAlignment.center, //沿主轴方向居中
  //           children: _buildWrap(item.words),
  //         ),
  //         // Divider(height: 1.0, color: Colors.red,),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildList() {
  //   return Store.connect<WordListStore>(builder: (context, store, child) {
  //     var dataList = store.wordList?.dataList;
  //     return dataList != null
  //         ? Column(children: dataList.map((item) => _buildItem(item)).toList())
  //         : View();
  //   });
  // }

  onSubmitted(String text) async {
    // final word = cont
    text = text.trim();
    if (text.isEmpty) return;
    // Navigator.popAndPushNamed(NavKey.navKey.currentContext, 'routeName');
    NavKey.navKey.currentState.pushNamed('wordDetail', arguments: text);
    // try {
    //   Navigator.pushNamed(NavKey.navKey.currentContext, 'wordDetail', arguments: text);
    // } catch (e) {
    //   print(['object', e]);
    // }
    // try {
    //   var res = await wordApi.getWord('hello');
    //   print(['object', json.encode(res)]);

    // } catch (e) {
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: TextView('单词列表'),
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0), // .symmetric(horizontal: 15),
        child: SafeArea(
          // _buildList()
          child: Column(
            children: <Widget>[
              View(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 0.5, color: MyColor.borderColor)
                ),
                child: Input(
                  controller: _controller,
                  placeholder: '输入要翻译的文本',
                  righetIcon: Icon(IconFont.close),
                  righetIconOnTap: () {
                    _controller.clear();
                  },
                  textInputAction: TextInputAction.search,
                  onSubmitted: onSubmitted
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  void getData() {
    Store.value<WordListStore>(context).getData();
  }
}
