//import 'package:flutter/material.dart';
//import 'package:town/components/town.dart';
//import 'package:town/components/layout/view.dart';

import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';

class LoginInputWrapper extends StatelessWidget {
  final Widget child;
  final IconData rightIcon;
  final Function onTapRightIcon;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  LoginInputWrapper(
      {
        Key key,
        this.child,
        this.margin,
        this.rightIcon,
        this.onTapRightIcon,
        this.padding = const EdgeInsets.only(left: 17)
      }
      ): super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Color _hintColor = Theme.of(context).hintColor;
    // final Color _backgroundColor = Theme.of(context).backgroundColor;
    return View(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: MyColor.backgroundColor,
            borderRadius: BorderRadius.circular(3)
        ),
        child: Row(
            children: <Widget>[
              Expanded(child: child),
//              rightIcon != null ? IconView(
//                rightIcon,
//                size: 15,
//                onTap: onTapRightIcon,
//                color: MyColor.hintColor,
//                padding: EdgeInsets.symmetric(horizontal: 17),
//              ) : Text('')
            ]
        )
    );
  }
}
