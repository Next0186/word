import 'dart:convert';

import 'package:translator/translator.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/word.dart';
import 'package:word/models/sentence_model.dart';

class Sentences extends StatefulWidget {
  final String sentences;
  Sentences(this.sentences, {Key key}) : super(key: key);

  @override
  _SentencesState createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
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
    final res = await translator.translate(sentences, from: 'en', to: 'zh-cn');
    setState(() => wordTranslate = res);
  }

  void getWord() {
    var wordList = sentences.split(' ');
    var wordReg = RegExp(r"^\w+$|^\w+\'\w+$");
    List<String> words = [];
    wordList.forEach((text) {
      print(['word', text]);
      if (wordReg.hasMatch(text)) words.add(text);
    });
    getData(words);
  }

  getData(List<String> wordList) async {
    try {
      var res = await wordApi.findWords(sentences, wordList);
      setState(() => sentence = SentenceModel.fromJson(res));
    } catch (e) {
      print(['添加句子失败', e]);
    }
  }

  _unStar() {
    print(['object', 'unstart']);
  }

  _showDialog() {
    print(['object', '_showDialog']);
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: '词裂',
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextView(sentences, size: 20,),
                      TextView('翻译：${wordTranslate?? ''}', )
                    ]
                  ),
                ),
                IconView(
                  star ? Icons.star : Icons.star_border,
                  color: Colors.redAccent,
                  onTap: star? _unStar : _showDialog,
                )
              ],
            )
          ]
        ),
      )
    );
  }
}