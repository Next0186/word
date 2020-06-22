import 'package:word/common/api/word_api.dart';
import 'package:word/components/word.dart';

class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getDate();
  }

  void getDate() async {
    try {
      var res = await wordApi.getCategoryList();
      print(['object', res]);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: []
      )
    );
  }
}