import 'dart:convert';

import 'package:translator/translator.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/layout/height_bar.dart';
import 'package:word/components/layout/image_build.dart';
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
      setState(() => sentence = SentenceModel.fromJson(res['data']));
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
      children: sentence.words.map((item) => InputChip(
        label: TextView(item.word),
        avatar:  item.wordImage.isNotEmpty ? ImageBuild(
          url:item.wordImage[0],
        ) : null,
      )).toList(),
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
            _buildWordItem()
          ]
        ),
      )
    );
  }
}