import 'package:webview_flutter/webview_flutter.dart';
import 'package:word/components/word.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  WebViewPage(this.url, {Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // var brightness = Brightness.dark;
  // Future<bool> _requestPop() {
  //   setState(() {
  //     brightness = Brightness.light;
  //   });
  //   return Future.value(true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted
        );
      },)
    );
  }
}