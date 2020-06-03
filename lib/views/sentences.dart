import 'dart:convert';

import 'package:word/common/api/word_api.dart';
import 'package:word/components/word.dart';

class Sentences extends StatefulWidget {
  final String sentences;
  Sentences(this.sentences, {Key key}) : super(key: key);

  @override
  _SentencesState createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
  String get sentences => widget.sentences;

  @override
  void initState() {
    super.initState();
    getWord();
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
      var res = await wordApi.findWords(wordList);
      print(['object', json.encode(res)]);
    } catch (e) {
      print(['添加句子失败', e]);
    }
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
                  child: TextView(sentences, size: 20,),
                ),
                
              ],
            )
          ]
        ),
      )
    );
  }
}