import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/layout/height_bar.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/sentences/category.dart';
import 'package:word/components/word.dart';
import 'package:word/models/sentence_model.dart';

class Sentences extends StatefulWidget {
  final String sentences;
  Sentences(this.sentences, {Key key}) : super(key: key);

  @override
  _SentencesState createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
  List<String> _words;
  String wordTranslate;
  SentenceModel sentence;

  String get sentences => widget.sentences;
  bool get star => sentence?.star != null ?? true;

  @override
  void initState() {
    super.initState();
    getWord();
    translate();
  }

  void translate() async {
    final translator = new GoogleTranslator();
    try {
      final res = await translator.translate(sentences, from: 'en', to: 'zh-cn');
      setState(() => wordTranslate = res);
    } catch (e) {
      print(['google翻译出错', e]);
    }
  }

  void getWord() {
    var wordList = sentences.split(' ');
    var wordReg = RegExp(r"^\w+$|^\w+\'\w+$");
    List<String> words = [];
    wordList.forEach((text) {
      if (wordReg.hasMatch(text)) words.add(text);
    });
    setState(() {
      _words = words;
    });
    getData();
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SentencesCategoryDialog(
          sentence.words.map((e) => e.word).toList(),
          widget.sentences,
          callBack: () {
            getData();
          },
        );
      }
    );
  }

  getData() async {
    try {
      var res = await wordApi.findWords(sentences, _words);
      setState((){
        sentence = SentenceModel.fromJson(res['data']);
      });
    } catch (e) {
      print(['添加句子失败', e]);
    }
  }

  _unStar() async {
    try {
      await wordApi.deleteCollectSentences(sentence.star.sId);
      getData();
      Fluttertoast.showToast(msg: '已取消收藏');
    } catch (e) {
    }
    print(['object', 'unstart']);
  }

  Widget _buildTopInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextView(sentences, size: 24,),
                Text.rich(TextSpan(children: [
                  TextSpan(text: '[翻译] ', style: TextStyle(color: MyColor.textColorSecondary)),
                  TextSpan(text: '  ${wordTranslate ?? ''}')
                ]))
              ]
            ),
          ),
          IconView(
            star ? Icons.star : Icons.star_border,
            color: Colors.redAccent,
            onTap: star? _unStar : _showDialog,
          )
        ],
      ),
    );
  }

  Widget _buildWordItem() {
    return sentence != null ? Wrap(
      spacing: 8,
      children: sentence.words.map((item) => InputChip(
        label: TextView(item.word),
        avatar:  item.wordImage.isNotEmpty ? ImageBuild(
          url:item.wordImage[0],
        ) : null,
        backgroundColor: Colors.black12,
        deleteIconColor: MyColor.errorColor.withOpacity(0.6),
        onDeleted: () {
          print(['delete']);
          sentence.words.remove(item);
          setState(() {
            sentence =  sentence; // sentence.words.remove(item);
          });
        },
      )).toList(),
    ) : View();
  }

  Widget _buildWordList() {
    var wordList = sentence?.words ?? [];

    List<Widget> buildList = [];
    wordList.forEach((e) {
      buildList.add(View(
        onTap: () {
          Navigator.pushNamed(context, 'wordDetail', arguments: e.word);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImageBuild(
              width: 80,
              height: 80,
              url: e.wordImage.isNotEmpty ? e.wordImage[0] : null,
              borderRadius: BorderRadius.circular(4),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextView(e.word, size: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: e.translate.map((text) => TextView(text)).toList()
                    ),
                    e.origins.isNotEmpty ? View(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: MyColor.backgroundColor
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: '词源：',
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              style: TextStyle(fontSize: 15),
                              text: e.origins[0].origin
                            )
                          ]
                        )
                      )
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                      //     TextView('词源：', size: 16),
                      //     TextView(e.origins[0].origin ?? '')
                      //   ]
                      // ),
                    ) : View()
                  ]
                ),
              ),
            )
          ],
        ),
      ));
      // buildList.add(HegihtBar(margin: EdgeInsets.symmetric(vertical: 10),));
      buildList.add(Divider(color: MyColor.borderColor,));
    });

    return wordList != null ? Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        children: buildList // wordList.map((e) => ).toList(),
      ),
    ) : View();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: '词裂',
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopInfo(),
            HegihtBar(),
            _buildWordItem(),
            HegihtBar(),
            _buildWordList()
          ]
        ),
      )
    );
  }
}