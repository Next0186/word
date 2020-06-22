import 'package:word/common/icon.dart';
import 'package:word/components/word.dart';
import 'package:word/views/collect_list.dart';
import 'package:word/views/home.dart';
import 'package:word/views/mine.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      title: Text('词典'),
      icon: Icon(IconFont.activity_circle),
      activeIcon: Icon(IconFont.activity_circle)
    ),
    BottomNavigationBarItem(
      title: Text('收藏'),
      icon: Icon(IconFont.activity_circle),
      activeIcon: Icon(IconFont.activity_circle)
    ),
    BottomNavigationBarItem(
      title: Text('我的'),
      icon: Icon(IconFont.activity_circle),
      activeIcon: Icon(IconFont.activity_circle)
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: IndexedStack(index: pageIndex, children: [
        Home(),
        CollectList(),
        Mine()
      ])
    );
  }
}