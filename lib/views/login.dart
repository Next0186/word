import 'package:fbutton/fbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fsuper/fsuper.dart';
import 'package:word/common/api/login_api.dart';
//import 'package:word/components/layout/user_phone.dart';
import 'package:word/components/word.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

//  _checkState() {}
  _submit() async {
    try {
      final res = await wordListApi.login(userName.text, password.text);
      print(['object', res]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: TextView('Welcome to login', size: 20, weight: FontWeight.w500,),
              ),
              TextField(
                controller: userName,
                maxLength: 11,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: '',
                    labelText: 'phone'
                )
              ),
              TextField(
                  controller: password,
                  obscureText: true,
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
                    FSuper(
                      text: '忘记密码？',
                      textColor: Color(0xffc2bfc2),
                      padding: EdgeInsets.all(2),
                      corner: Corner.all(3),
                      strokeColor: Color(0xffc2bfc2),
                      strokeWidth: 1,
                      onClick: () {
                        Fluttertoast.showToast(msg: '功能开发中...');
                      },
                    ),
                    FSuper(
                      text: '立刻注册',
                      textColor: Color(0xff0ecc88),
                      padding: EdgeInsets.all(2),
                      corner: Corner.all(3),
                      strokeColor: Color(0xff0ecc88),
                      strokeWidth: 1,
                      onClick: () {
                        Navigator.pushNamed(context, 'signup');
                      }
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
                onPressed: _submit,
                clickEffect: true,
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