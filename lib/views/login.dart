import 'package:fbutton/fbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsuper/fsuper.dart';
import 'package:word/common/api/user_api.dart';
//import 'package:word/components/layout/user_phone.dart';
import 'package:word/components/word.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool canLogin = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  _submit() async {
    try {
      final userName = _userName.text;
      final password = _password.text;
      if (userName.isEmpty) Fluttertoast.showToast(msg: null);
      final res = await userApi.login(userName, password);
      print(['object', res]);
    } catch (e) {
      print(e);
    }
  }

  onChanged(String text) {
    final userName = _userName.text;
    final password = _password.text;
    setState(() {
      canLogin = userName.isNotEmpty && password.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: TextView('Welcome to Magneto', size: 20, weight: FontWeight.w500, textAlign: TextAlign.center,),
              ),
              TextField(
                maxLength: 11,
                onChanged: onChanged,
                controller: _userName,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    counterText: '',
                    labelText: 'name or email'
                )
              ),
              TextField(
                  obscureText: true,
                  onChanged: onChanged,
                  controller: _password,
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: 'password'
                  )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(
                      tag: 'title', 
                      child: FSuper(
                        text: '找回密码',
                        textColor: Color(0xffc2bfc2),
                        padding: EdgeInsets.all(2),
                        corner: Corner.all(3),
                        strokeColor: Color(0xffc2bfc2),
                        strokeWidth: 1,
                        onClick: () {
                          Navigator.pushNamed(context, 'retrieve', arguments: '找回密码');
                          // Fluttertoast.showToast(msg: '功能开发中...');
                        },
                      ),
                    ),
                    Hero(
                      tag: 'signup',
                      child: FSuper(
                        text: '用户注册',
                        textColor: Color(0xff0ecc88),
                        padding: EdgeInsets.all(2),
                        corner: Corner.all(3),
                        strokeColor: Color(0xff0ecc88),
                        strokeWidth: 1,
                        onClick: () {
                          Navigator.pushNamed(context, 'signup');
                        }
                      ),
                    ),
                  ],
                ),
              ),
              FButton(
                // width: 200,
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
            ],
          ),
        )
      )
    );
  }
}