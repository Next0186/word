import 'package:fbutton/fbutton.dart';
import 'package:word/components/word.dart';
import 'package:translator/translator.dart';
import 'package:word/models/word_model.dart';
import 'package:word/common/api/word_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/models/word_desc_model.dart';
import 'package:word/components/layout/color.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:word/components/layout/height_bar.dart';
import 'package:word/components/layout/image_build.dart';
import 'package:word/components/word_detail/category.dart';

class WordDetail extends StatefulWidget {
  final String word;
  const WordDetail(this.word, {Key key}) : super(key: key);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  WordModel word;
  WordDesc changeItem;
  WordDescModel wordDesc;
  bool editingLog = false;
  var brightness = Brightness.dark;
  final translator = GoogleTranslator();
  AudioPlayer audioPlayer = AudioPlayer();
  FocusNode textFocusNode = FocusNode();
  TextEditingController _logController = TextEditingController();

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
      print(['获取单词信息失败', e]);
    }
  }

  @override
  void deactivate() async {
    audioPlayer.dispose();
    super.deactivate();
  }

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
          word.wordImage.isNotEmpty ? ImageBuild(
            url: word.wordImage[0],
            width: 80,
            height: 80,
            borderRadius: BorderRadius.circular(4),
          ) : View()
        ],
      ),
    );
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryDialog(
          widget.word,
          callBack: () {
            getWord();
          },
        );
      }
    );
  }
  _unStar() async {
    var categoryId = word.starList[0].sId;
    try {
      await wordApi.removeCollectWord(widget.word, categoryId);
      Fluttertoast.showToast(msg: '已取消收藏');
      word.starList = [];
      setState(() => word = word);
    } catch (e) {
      print(['取消收藏失败', e]);
    }
  }
  // 发音图片
  Widget _buildWordText() {
    var star = word.starList.length > 0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextView(word.word, size: 26,),
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

  Widget _buildOriginEn() {
    return _buidlWrapper('词源（英文）', View(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: widget.word,
              style: TextStyle(
                fontSize: 22,
                color: MyColor.linkColor,
                decoration:TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: ' （需要翻墙）',
              style: TextStyle(color: MyColor.textColorSecondary)
            )
          ])
      ),
      onTap: () {
        // Navigator.pushNamed(context, 'webView', arguments: 'https://www.baidu.com');
        Navigator.pushNamed(context, 'webView', arguments: 'https://www.etymonline.com/search?q=${widget.word}');
      },
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

  addLog() {
    if(changeItem != null) {
      updateLog();
    } else if (editingLog) { pushDesc(); }
    setState(() {
      editingLog = !editingLog;
    });
  }

  updateLog() async {
    var id = changeItem.sId;
    var text = _logController.text;
    try {
      await wordApi.updateWordDesc(id, text);
      word.wordDesc.forEach((element) {
        if (element.sId == changeItem.sId) {
          element.desc = text;
        }
      });
      setState(() {
        word = word;
        editingLog = false;
      });
      Fluttertoast.showToast(msg: '更新成功');
      changeItem = null;
      _logController.text = '';
    } catch (e) {
    }
  }

  pushDesc() async {
    String desc = _logController.text;
    if (desc == '' || desc == null) return;
    try {
      var res = await wordApi.addWordDesc(widget.word, desc);
      _logController.text = '';
      word.wordDesc.add(WordDesc.fromJson(res['data']));
      setState(() {word = word;});
      print(['object', res]);
    } catch (e) {
      print(['error', e]);
    }
  }

  Widget _buildMyWordLog() {
    var desc = word?.wordDesc ?? [];
    final List<Widget> children = [];
    for (var i = 0; i < desc.length; i++) {
      var item = desc[i];
      children.add(Slidable(
        actionExtentRatio: 0.25,
        actionPane: SlidableDrawerActionPane(),
        child: View(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: MyColor.backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextView('${i+1}、${item.desc}', size: 16, color: Colors.black45,)
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: '编辑',
            icon: Icons.edit,
            color: Colors.black45,
            onTap:(){ editItem(item); },
          ),
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () { deleteDescItem(item); },
          ),
        ],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children
    );
  }

  Future<void> editItem(WordDesc item) async {
    changeItem = item;
    setState(() {
      editingLog = true;
    });
    FocusScope.of(context).requestFocus(textFocusNode);
    _logController.text = item.desc;
  }

  void deleteDescItem(WordDesc item) async {
    FocusScope.of(context).requestFocus(textFocusNode);
    try {
      var res = await wordApi.deleteWordDesc(item.sId);
      word.wordDesc.remove(item);
      setState(() { word = word; });
      print(['object', res]);
    } catch (e) {
      print(['delete', e]);
    }
    print(['object', 'delete']);
  }

  Widget _buildLogEdit() {
    return View(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: MyColor.backgroundColor
      ),
      child:TextField(
        minLines: 1,
        maxLines: 6,
        focusNode: textFocusNode,
        decoration: InputDecoration(
          hintText: '请输入内容'
        ),
        controller: _logController,
      )
    );
  }

  Widget _buildPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        View(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: MyColor.borderColor))
          ),
          child: TextView('单词笔记',size: 20,),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMyWordLog(),
                editingLog ? _buildLogEdit() : View(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FButton(
                    effect: true,
                    text: editingLog ? '保存': '添加笔记',
                    textColor: Colors.white,
                    color: Color(0xffffc900),
                    onPressed: addLog,
                    clickEffect: true,
                    disabledColor: Color(0x66ffc900),
                    corner: FButtonCorner.all(9),
                    splashColor: Color(0xffff7043),
                    highlightColor: Color(0xffE65100).withOpacity(0.20),
                    hoverColor: Colors.redAccent.withOpacity(0.16),
                  ),
                )
              ]
            )
          ),
        )
      ],
    );
  }

  Future<bool> _requestPop() {
    setState(() {
      brightness = Brightness.light;
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: TextView('单词详情', color: Colors.white,),
          brightness: brightness,
        ),
        body: SlidingUpPanel(
          borderRadius: radius,
          panel: _buildPanel(),
          body: word != null ? SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 200),
            child: word.sId != null ? Column(
              children: [
                _buildWordText(),
                _buildPronunciation(),
                Padding(padding: EdgeInsets.only(top: 10),child: HegihtBar(),),
                _buildTranslate(),
                HegihtBar(),
                _buildOrigin(),
                HegihtBar(),
                _buildOriginEn(),
                HegihtBar(),
                _buildExample(),
              ]
            ) : View(
              child: TextView('没有相关单词'),
            ),
          ) : View(
            alignment: Alignment.center,
            child: TextView('查找中请稍等'),
          ),
        )
      ),
    );
  }
}