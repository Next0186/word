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

  Widget _buildItem(DataList item) {
    return Column(
      children: <Widget>[
        TextView(item.sentence),
        TextView(item.translate),

      ],
    );
  }

  Widget _buildList() {
    return Store.connect<WordListModel>(builder: (context, store, child){
      return Column(
        children: store.dataList.map((item) => _buildItem(item)).toList()
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: _buildList()
      ),
    );
  }

  void getData() {
    Store.value<WordListStore>(context).getData();
  }
}
