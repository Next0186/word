import 'package:fbutton/fbutton.dart';
import 'package:word/store/provider.dart';
import 'package:word/components/word.dart';
import 'package:word/common/api/user_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:word/store/module/user_info_store.dart';

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
      Store.value<UserInfoStore>(context).setUserInfo(res['data']);
      Navigator.of(context).pushNamedAndRemoveUntil('homePage', (route) => route == null);
      Fluttertoast.showToast(msg: '登录成功');
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

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
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
                      flightShuttleBuilder: _flightShuttleBuilder,
                      child: TextView(
                        '找回密码',
                        textAlign: TextAlign.center,
                        // color: Color(0xff0ecc88),
                        onTap: () {
                          Navigator.pushNamed(context, 'retrieve', arguments: '找回密码');
                        },
                      )
                    ),
                    Hero(
                      tag: 'signup',
                      flightShuttleBuilder: _flightShuttleBuilder,
                      child: TextView(
                        '用户注册',
                        textAlign: TextAlign.center,
                        onTap: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                      )
                    )
                    // View(
                    //   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(4),
                    //     // border: Border.all(width: 0.5, color: Color(0xff0ecc88))
                    //   ),
                    //   child: ,
                    // ),
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