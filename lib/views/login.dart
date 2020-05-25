import 'package:fbutton/fbutton.dart';
import 'package:word/common/api/login_api.dart';
//import 'package:word/components/layout/user_phone.dart';
import 'package:word/components/word.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _userPhome = TextEditingController();
  TextEditingController _userPassword = TextEditingController();

//  _checkState() {}
  _submit() async {
    try {
      final res = await wordListApi.login('15626030186', 'dong1122');
      print(['object', res]);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: _userPhome,
                maxLength: 11,
//                onChanged: onChanged,
//                controller: controller,
//                obscureText: obscureText,
                style: TextStyle(fontSize: 16),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: '',
                    labelText: 'phone'
                )
              ),
              TextField(
                  controller: _userPassword,
                  obscureText: true,
                  style: TextStyle(fontSize: 16),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: 'password'
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: FButton(
                  width: 200,
                  effect: true,
                  text: "Try Me!",
                  textColor: Colors.white,
                  color: Color(0xffffc900),
                  onPressed: _submit,
                  clickEffect: true,
                  corner: FButtonCorner.all(9),
                  splashColor: Color(0xffff7043),
                  highlightColor: Color(0xffE65100).withOpacity(0.20),
                  hoverColor: Colors.redAccent.withOpacity(0.16),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}