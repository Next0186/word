import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word.dart';
import 'package:word/models/word_list_model.dart';
import 'package:word/store/provider.dart';
import 'package:word/store/module/word_list_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  List<Widget> _buildWrap(List<Words> words) {
    return words.map((item) => GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('wordDetail', arguments: item);
      },
      child: Chip(
        avatar: ImageBuild(
          url: item.avatar,
          borderRadius: BorderRadius.circular(20)
        ),
        label: TextView(item.word),
      )
    )).toList();
  }

  Widget _buildItem(DataList item) {
    // print(await "example".translate(to: 'pt'));
    return View(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey))
      ),
      child: Column(
        children: <Widget>[
          TextView(
            item.sentence,
            size: 16,
            margin: EdgeInsets.only(bottom: 2),
          ),
          TextView(
            '翻译：\n${item.translate}',
            size: 16,
          ),
          Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: _buildWrap(item.words),
          ),
          // Divider(height: 1.0, color: Colors.red,),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Store.connect<WordListStore>(builder: (context, store, child) {
      var dataList = store.wordList?.dataList;
      return dataList != null
          ? Column(children: dataList.map((item) => _buildItem(item)).toList())
          : View();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextView('单词列表'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15), child: _buildList()),
    );
  }

  void getData() {
    Store.value<WordListStore>(context).getData();
  }
}
