import 'package:translator/translator.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word.dart';
import 'package:word/models/word_list_model.dart';

class WordDetail extends StatefulWidget {
  final Words item;
  const WordDetail({Key key, this.item}) : super(key: key);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  /*
{
  "from": "en"
"to": "zh"
"query": "world"
"simple_means_flag": 3
"sign": 335290.130699
"token": "a538203463b29f513b706cf8b9db1592"
"domain": "common"
}
  
  
  */

  final translator = GoogleTranslator();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // translate();
  }

  void translate() async {
    final res = await translator.translate(detail.word, from: 'en', to: 'zh-cn');
    print(['object', res]);
  }


  Words get detail => widget.item;

  Widget _buildPronunciation() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  TextView('英 /${detail.sign.en}/ '),
                  Icon(Icons.play_circle_outline, color: Colors.redAccent,),
                ],
              ),
              Row(
                children: <Widget>[
                  TextView('美 /${detail.sign.us}/ '),
                  Icon(Icons.play_circle_outline, color: Colors.redAccent,),
                ],
              )
            ]
          )
        ),
        ImageBuild(
          url: detail.avatar,
          width: 80,
          height: 80,
          borderRadius: BorderRadius.circular(4),
        )
      ],
    );
  }

  Widget _buildWordText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextView(detail.word, size: 22,),
          ),
          Icon(Icons.star_border, color: Colors.redAccent,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: TextView('单词 详情')
      ),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            _buildWordText(),
            _buildPronunciation(),

          ]
        ),
      )
    );
  }
}