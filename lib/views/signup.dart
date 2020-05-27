import 'dart:async';

import 'package:fbutton/fbutton.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/common/api/user_api.dart';
import 'package:word/components/word.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool canget = false;
  bool canLogin = false;
  bool loading = false;
  String getCodeText = 'get code';
  RegExp emailReg = RegExp('^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+\$');
  TextEditingController _code = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();

  onChanged(String text) {
    final code = _code.text;
    final name = _name.text;
    final email = _email.text;
    final password = _password.text;
    setState(() {
      canLogin = code.isNotEmpty && name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
    });
  }

  emailChanged(String email) {
    setState(() {
      canget = emailReg.hasMatch(email);
    });
  }

  getCode() async {
    if (loading) return;
    setState(() {
      loading = true;
    });
    int count = 60;
    Timer.periodic(Duration(seconds: 1), (timer) {
      count--;
      if (count == 0) {
        timer.cancel();
        timer = null;
        setState(() {
          loading = false;
          getCodeText = 'get code';
        });
      } else {
        setState(() {
          getCodeText = 'retry after ${count}s';
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
    var userName = _name.text;
    var password = _password.text;
    var code = _code.text.toUpperCase();
    var email = _email.text;
    try {
      var userInfo =  await userApi.signup(userName: userName, code: code, password: password, email: email);
      // Fluttertoast.showToast(msg: 'null')
      print(['object', userInfo]);
    } catch (e) {
      // Fluttertoast.showToast(msg: '登录失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Hero(
                  tag: 'signup',
                  child: TextView(
                    '用户注册',
                    size: 20,
                    weight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  )
                ),
              ),
              TextField(
                controller: _email,
                onChanged: emailChanged,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(counterText: '', labelText: 'email'),
              ),
              TextField(
                maxLength: 11,
                controller: _name,
                onChanged: onChanged,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(counterText: '', labelText: 'name'),
              ),
              TextField(
                obscureText: true,
                maxLength: 11,
                controller: _password,
                onChanged: onChanged,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(counterText: '', labelText: 'password'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLength: 11,
                      controller: _code,
                      onChanged: onChanged,
                      style: TextStyle(fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(counterText: '', labelText: 'code'),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: FButton(
                  effect: true,
                  text: "Try This!",
                  textColor: Colors.white,
                  color: Color(0xffffc900),
                  onPressed: canLogin ? _submit : null,
                  clickEffect: true,
                  disabledColor: Color(0x66ffc900),
                  corner: FButtonCorner.all(9),
                  splashColor: Color(0xffff7043),
                  highlightColor: Color(0xffE65100).withOpacity(0.20),
                  hoverColor: Colors.redAccent.withOpacity(0.16),
                ),
              )
            ],
          ),
        ));
  }
}
