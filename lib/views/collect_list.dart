import 'package:word/components/word.dart';

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
        title: TextView('收藏列表'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: '单词'),
            Tab(text: '句子')
          ]
        ),
      ),
      // title: TextView('收藏列表')
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[

        ],
      ),
    );
    // return PageLayout(
    //   title: '收藏列表',
    //   body: Container(
    //     child: TextView('11111111111'),
    //   ),
    // );
  }
}