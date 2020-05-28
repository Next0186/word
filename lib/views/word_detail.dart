import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/layout/height_bar.dart';
// import 'package:word/common/api/word_list_api.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word.dart';
// import 'package:word/models/word_detail_model.dart';
import 'package:word/models/word_model.dart';

class WordDetail extends StatefulWidget {
  final String word;
  const WordDetail(this.word, {Key key}) : super(key: key);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  WordModel word;
  final translator = GoogleTranslator();
  // WordDetailModel detail ;
  AudioPlayer audioPlayer = AudioPlayer();

  var padding = EdgeInsets.symmetric(horizontal: 15, vertical: 10);


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // translate();
    getWord();
  }

  getWord() async {
    try {
      var res = await wordApi.getWord(widget.word);
      setState(() {
        word = WordModel.fromJson(res['data']);
      });
    } catch (e) {
    }
  }

  @override
  void deactivate() async {
    audioPlayer.dispose();
    super.deactivate();
  }

  // void translate() async {
  //   final res = await wordListApi.findWord(widget.item.word);
  //   setState(() {
  //     detail = WordDetailModel.fromJson(res['data']);
  //   });
  // }

  Widget _buildPronunciation() {
    const outline = Icon(Icons.play_circle_outline, color: Colors.redAccent, size: 20);
    Widget _audioItem(int type) {
      var audio = type == 1 ? word.pronounce.en : word.pronounce.us;
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
                  await audioPlayer.play('${word.wordAudio}$type');
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
          word.wordImage[0] != null ? ImageBuild(
            url: word.wordImage[0],
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(4),
          ) : View()
        ],
      ),
    );
  }

  // 发音图片
  Widget _buildWordText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextView(word.word, size: 26,),
          ),
          IconView(word.starList.length > 0 ? Icons.star : Icons.star_border, color: Colors.redAccent,)
        ],
      ),
    );
  }

  // 翻译
  Widget _buildTranslate() {
    List<TextView> worsText = word.translate.map((i) {
      return TextView(i, size: 16,);
    }).toList();
    worsText.add(TextView(
      word.rank,
      size:14,
      color: MyColor.textColorSecondary,
      margin: EdgeInsets.only(top: 6),
    ));
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: worsText,
      )
    );
  }

  // 词源
  Widget _buildOrigin() {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView('词源：', size: 18, weight: FontWeight.w500,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: word.origins.map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextView(e.title, size: 18, margin: EdgeInsets.only(top: 8, bottom: 2),),
                TextView(e.origin, size: 16, ),
              ]
            )).toList()
          )
        ],
      ),
    );
  }

  Widget _buildExample() {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextView('例句：', size: 18, weight: FontWeight.w500,),
          TextView(word.example.en, size: 16, margin: EdgeInsets.symmetric(vertical: 4),),
          TextView(word.example.zh, size: 16,)
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
        title: TextView('单词详情')
      ),
      body: word != null ? SingleChildScrollView(
        child: word.sId != null ? Column(
          children: [
            _buildWordText(),
            _buildPronunciation(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: HegihtBar(),
            ),
             _buildTranslate(),
             HegihtBar(),
             _buildOrigin(),
             HegihtBar(),
             _buildExample()
            // TextView(word.translate)
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