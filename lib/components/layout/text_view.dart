import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final int maxLines;
  final double height;
  final Function onTap;
  final String fontFamily;
  final FontWeight weight;
  final TextAlign textAlign;
  final Color backgroundColor;
  final TextOverflow overflow;
  final EdgeInsetsGeometry margin;
  const TextView(this.text, {
    Key key,
    this.size,
    this.color,
    this.onTap,
    this.weight,
    this.height,
    this.margin,
    this.overflow,
    this.maxLines,
    this.textAlign,
    this.fontFamily,
    this.backgroundColor,
  }) : super(key: key);

  Widget _buildText() {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: size,
        fontWeight: weight,
        fontFamily: fontFamily,
        backgroundColor: backgroundColor,
      )
    );
  }

  Widget _buildView() {
    return margin != null ? Padding(
      padding: margin,
      child: _buildText()
    ) : _buildText();
  }

  Widget _buildTapView() {
    return onTap != null ? GestureDetector(
      onTap: onTap,
      child: _buildView(),
    ) : _buildView();
  }


  @override
  Widget build(BuildContext context) {
    return _buildTapView();
  }
}