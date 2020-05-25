//import 'package:town/components/town.dart';
//import 'package:town/components/login/login_input_wrapper.dart';

//import 'package:word/components/word.dart';

import 'package:flutter/material.dart';
import 'package:word/components/layout/login_input_wrapper.dart';

class UserPhoneBar extends StatelessWidget {
  final int maxLength;
  final String labelText;
  final bool obscureText;
  final Function onChanged;
  final EdgeInsetsGeometry margin;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const UserPhoneBar({
    Key key,
    this.onChanged,
    this.controller,
    this.maxLength = 11,
    this.obscureText = false,
    this.labelText = '请输入你的手机号码',
    this.keyboardType = TextInputType.phone,
    this.margin: const EdgeInsets.only(bottom: 10, top: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginInputWrapper(
        margin: margin,
        child: TextField(
            maxLength: 11,
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(fontSize: 16),
            keyboardType: keyboardType,
            decoration: InputDecoration(
                counterText: '',
                labelText: labelText
            )
        )
    );
  }
}