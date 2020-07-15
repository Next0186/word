import 'package:word/components/word.dart';
import 'package:word/views/sentences_list.dart';
import 'package:word/views/category_list.dart';

class CollectList extends StatefulWidget {
  CollectList({Key key}) : super(key: key);

  @override
  _CollectListState createState() => _CollectListState();
}

class _CollectListState extends State<CollectList> with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller

    @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextView('收藏列表', color: Colors.white,),
        brightness: Brightness.dark,
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(child: TextView('单词', size: 16, color: Colors.white),),
            Tab(child: TextView('句子', size: 16, color: Colors.white),)
          ]
        ),
      ),
      // title: TextView('收藏列表')
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CategoryList(),
          SentencesList()
        ],
      ),
    );
  }
}