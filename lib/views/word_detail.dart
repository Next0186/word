import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';
import 'package:word/common/api/word_list_api.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word.dart';
import 'package:word/models/word_detail_model.dart';
import 'package:word/models/word_list_model.dart';
// import 'package:word/models/word_list_model.dart';

class WordDetail extends StatefulWidget {
  final Words item;
  const WordDetail({Key key, this.item}) : super(key: key);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {

  final translator = GoogleTranslator();

  // Words get detail => widget.item;
  WordDetailModel detail ;
  AudioPlayer audioPlayer = AudioPlayer();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate();
  }

  @override
  void deactivate() async {
    audioPlayer.dispose();
    super.deactivate();
  }

  void translate() async {
    final res = await wordListApi.findWord(widget.item.word);
    setState(() {
      detail = WordDetailModel.fromJson(res['data']);
    });
    // final res = await translator.translate(detail.word, from: 'en', to: 'zh-cn');
    // print(['object', res]);
  }

  Widget _buildPronunciation() {
    const outline = Icon(Icons.play_circle_outline, color: Colors.redAccent, size: 20);
    Widget _audioItem(int type) {
      var audio = type == 1 ? detail.pronounce.en : detail.pronounce.us;
      return View(
        height: 40,
        // padding: EdgeInsets.only(bottom: type == 1 ? 6 : 0),
        child: Row(
          children: <Widget>[
            TextView('${type == 1 ? '英' : '美'} $audio ', size: 16,),
            GestureDetector(
              child: outline,
              onTap: () async {
                try {
                  await audioPlayer.play('${detail.wordAudio}$type');
                } catch (e) {
                  Fluttertoast.showToast(msg: '播放失败');
                }
              }
            )
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                _audioItem(1),
                _audioItem(2),
              ]
            )
          ),
          detail.wordImage[0] != null ? ImageBuild(
            url: detail.wordImage[0],
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(4),
          ) : View()
        ],
      ),
    );
  }

  Widget _buildWordText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextView(detail.word, size: 26,),
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
      body: detail != null ? SingleChildScrollView(
        
        child: !detail.notFind ? Column(
          children: [
            _buildWordText(),
            _buildPronunciation(),

          ]
        ) : View(
          child: TextView('没有相关单词'),
        ),
      ) : View(
        alignment: Alignment.center,
        child: TextView('查找中请稍等'),
      )
    );
  }
}