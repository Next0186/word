import 'package:word/components/word.dart';

class PageLayout extends StatefulWidget {
  final String title;
  final Widget body;
  PageLayout({Key key, this.title, this.body}) : super(key: key);

  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  var brightness = Brightness.dark;

  Future<bool> _requestPop() {
    setState(() {
      brightness = Brightness.light;
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: TextView(widget.title, color: Colors.white,),
          brightness: brightness,
        ),
        body: widget.body,
      ),
    );
  }
}
