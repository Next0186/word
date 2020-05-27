import 'dart:async';

import 'package:fbutton/fbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/common/api/user_api.dart';
import 'package:word/components/word.dart';

class Retrieve extends StatefulWidget {
  final String title;
  Retrieve({Key key, this.title}) : super(key: key);

  @override
  _RetrieveState createState() => _RetrieveState();
}

class _RetrieveState extends State<Retrieve> {
  var canget = false;
  var loading = false;
  var canSubmit = false;
  var getCodeText = '获取验证码';
  RegExp emailReg = RegExp('^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+\$');
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _code = TextEditingController();

  emailChanged(String email) {
    setState(() {
      canget = emailReg.hasMatch(email);
    });
  }

  onChanged(String txt) {
    var email = _email.text;
    var pass = _password.text;
    var code = _code.text;
    setState(() {
      canSubmit = email.isNotEmpty && pass.isNotEmpty && code.isNotEmpty;
    });
  }

  getCode() async {
    if (loading) return;
    setState(() { loading = true; });
    int count = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      count--;
      if (count == 0) {
        timer.cancel();
        timer = null;
        setState(() {
          loading = false;
          getCodeText = '获取验证码';
        });
      } else {
        setState(() {
          getCodeText = '${count}s 后重试';
        });
      }
    });
    try {
      await userApi.getCode(_email.text);
      Fluttertoast.showToast(msg: '获取验证码成功');
    } catch (e) {
      print(['获取验证码失败', e]);
      // Fluttertoast.showToast(msg: '获取验证码成功');
    }
  }

  _submit() async {
    var code = _code.text.toUpperCase();
    var email = _email.text;
    var password = _password.text;
    try {
      await userApi.findPassword(email, password, code);
      Fluttertoast.showToast(msg: '${widget.title}成功');
      Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => route == null);
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          tag: 'title',
          child: TextView(widget.title),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: _email,
              onChanged: emailChanged,
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(counterText: '', labelText: 'email'),
            ),
            TextField(
              obscureText: true,
              controller: _password,
              onChanged: onChanged,
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(counterText: '', labelText: '新密码'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 11,
                    controller: _code,
                    onChanged: onChanged,
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(counterText: '', labelText: 'code'),
                  ),
                ),
                FButton(
                  height: 40,
                  effect: true,
                  text: getCodeText,
                  clickEffect: true,
                  textColor: Colors.white,
                  color: Color(0xffffc900),
                  corner: FButtonCorner.all(4),
                  splashColor: Color(0xffff7043),
                  disabledColor: Color(0x66ffc900),
                  onPressed: canget && !loading ? getCode : null,
                  hoverColor: Colors.redAccent.withOpacity(0.16),
                  highlightColor: Color(0xffE65100).withOpacity(0.20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                ),
              ]
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: FButton(
                effect: true,
                text: "Try This!",
                textColor: Colors.white,
                color: Color(0xffffc900),
                onPressed: canSubmit ? _submit : null,
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
    );
  }
}
