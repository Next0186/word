import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:translator/translator.dart';
import 'package:word/common/api/word_api.dart';
import 'package:word/common/icon.dart';
import 'package:word/components/layout/color.dart';
import 'package:word/components/layout/height_bar.dart';
// import 'package:word/common/api/word_list_api.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word.dart';
import 'package:word/models/word_desc_model.dart';
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
  WordDescModel wordDesc;
  final translator = GoogleTranslator();
  // WordDetailModel detail ;
  AudioPlayer audioPlayer = AudioPlayer();

  var padding = EdgeInsets.symmetric(horizontal: 15, vertical: 10);


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWord();
  }

  getWord() async {
    try {
      var _word = widget.word;
      var data = await wordApi.getWord(_word);
      setState(() {
        word = WordModel.fromJson(data['data']);
      });
    } catch (e) {
      print(['object111111111111', e]);
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

  Widget _buidlWrapper(String title, Widget content) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextView(title, size: 18, weight: FontWeight.w500,),
          content
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10),
          //   child: content,
          // )
        ]
      ),
    );
  }

  // 词源
  Widget _buildOrigin() {
    return _buidlWrapper('词源：', Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: word.origins.map((e) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextView(e.title, size: 18, margin: EdgeInsets.only(top: 8, bottom: 2), color: Colors.black54,),
          View(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: MyColor.backgroundColor
            ),
            child: TextView(e.origin, size: 16, color: Colors.black45,),
          )
        ]
      )).toList()
    ));
  }

  Widget _buildExample() {
    return _buidlWrapper('例句：', Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextView(word.example.en, size: 16, margin: EdgeInsets.symmetric(vertical: 6), color: Colors.black45,),
        TextView(word.example.zh, size: 16, color: Colors.black45,)
      ]
    ));
  }

  Widget _buildMyWordLog() {
    var desc = word?.wordDesc;
    return _buidlWrapper('我的单词笔记：', Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: desc != null ? desc.map((item) => View(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.backgroundColor
        ),
        child: TextView(item.desc, size: 16, color: Colors.black45,)
      )).toList() : []
      // <Widget>[
      //   View(
      //     margin: EdgeInsets.symmetric(vertical: 8),
      //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(4),
      //       color: MyColor.backgroundColor
      //     ),
      //     child: TextView(wordDesc.myDesc.desc, size: 16, color: Colors.black45,)
      //   )
      // ] : [],
    ));
  }

  // Widget _buildCommonDesc() {
  //   return _buidlWrapper('大家的单词笔记', Column(
  //     children: word.wordDesc.map((item) => Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           // _buildDescTitle(item),
  //           View(
  //             margin: EdgeInsets.only(top: 12),
  //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(4),
  //               color: MyColor.backgroundColor
  //             ),
  //             child: TextView(item.desc, size: 16, ),
  //           )
  //         ]
  //       )
  //     )).toList()
  //   ));
  // }

  // Widget _buildDescTitle(WordDesc item) {
  //   return Row(
  //     children: <Widget>[
  //       ImageBuild(
  //         url: item.avatar,
  //         width: 56,
  //         height: 56,
  //         borderRadius: BorderRadius.circular(4)
  //       ),
  //       Expanded(
  //         child: View(
  //           height: 56,
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               TextView(item.userName, size: 18, color: Colors.black54,),
  //               TextView(item.updateAt, color: Colors.black38,)
  //             ]
  //           ),
  //         ),
  //       ),
  //       IconView(IconFont.praise, size: 18, color: Colors.black26,)
  //     ],);
  // }

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
             _buildExample(),
             HegihtBar(),
             _buildMyWordLog(),
            //  HegihtBar(),
            //  _buildCommonDesc()
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