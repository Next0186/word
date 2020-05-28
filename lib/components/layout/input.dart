import 'package:flutter/material.dart';
// import 'package:word/common/icon.dart';
import 'package:word/components/layout/color.dart';
// import 'package:town/common/util/util.dart';
// import 'package:town/common/layout/color.dart';

class Input extends StatefulWidget {
  /// 自动获取焦点
  final bool autofocus;
  /// 是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
  final bool obscureText;
  /// 是否自动校正
  final bool autocorrect;
  /// 占位符
  final String placeholder;
  /// 只读
  final bool readOnly;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final GestureTapCallback onTap;
  final bool maxLengthEnforced;
  final TextStyle style;
  final StrutStyle strutStyle;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget righetIcon;
  final Function(String text) onChanged;
  final ValueChanged<String> onSubmitted;
  final Function() righetIconOnTap;

  /// 工具栏选项的配置。
  /// 如果未设置，请全选并默认粘贴。 复制并剪切
  /// 如果 obscureText 或者 readOnly为true，则将被禁用。
  final ToolbarOptions toolbarOptions;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  Input({
    Key key,
    this.style,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.autofocus = false,
    this.righetIcon,
    this.strutStyle,
    this.placeholder,
    this.onSubmitted,
    this.obscureText = false,
    this.autocorrect = false,
    this.controller,
    this.keyboardType,
    this.toolbarOptions,
    this.textInputAction,
    this.righetIconOnTap,
    this.maxLengthEnforced = false,
    this.decoration = const InputDecoration(border: InputBorder.none),
    this.textCapitalization = TextCapitalization.none

    // InputDecoration(
    //         border: InputBorder.none,
    //       )
  }) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _hidePlaceholder = false;
  String get placeholder => widget.placeholder ?? '';
  TextEditingController get controller => widget.controller ?? TextEditingController();

  @override
  void initState() { 
    super.initState();
    controller.addListener(() {
      onChanged();
      print(['object', 'object']);
    });
  }

  onChanged() {
    var text = controller.text;
    bool _hide = text.length > 0;
    if (_hide != _hidePlaceholder) {
      setState(() {
        _hidePlaceholder = _hide;
      });
    }
  }

  // show_hidePlaceholder

  /// 完成编辑
  onEditingComplete() {}
   
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(top: widget.maxLines > 1 ? 0 : 10),
            child: Text(
              _hidePlaceholder ? '' : placeholder,
              style: TextStyle(color: MyColor.textColorSecondary, fontSize: 18),
            ),
          )
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                onSubmitted: widget.onSubmitted,
                style: widget.style,
                onTap: widget.onTap,
                onChanged: widget.onChanged,
                decoration: widget.decoration,
                onEditingComplete: onEditingComplete,
                controller: controller,
                readOnly: widget.readOnly,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                maxLengthEnforced: widget.maxLengthEnforced,
                autofocus: widget.autofocus,
                obscureText: widget.obscureText,
                autocorrect: widget.autocorrect,
                keyboardType: widget.keyboardType,
                toolbarOptions: widget.toolbarOptions,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization
              ),
            ),
            widget.righetIcon != null ? Padding(
              padding: EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  widget?.righetIconOnTap();
                },
                child: widget.righetIcon
              ),
            ) : Container()
          ],
        ),
      ]
    );
  }
}