import 'package:flutter/material.dart';
import 'package:word/components/layout/view.dart';

class IconView extends StatelessWidget {
  final double size;
  final Color color;
  final String label;
  final double width;
  final double height;
  final IconData icon;
  final Function onTap;
  final Decoration decoration;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  const IconView(this.icon, {
    Key key,
    this.size,
    this.color,
    this.onTap,
    this.label,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration
  }) : super(key: key);

  Widget _buildIcon() {
    return Icon(icon, size: size, color: color, semanticLabel: label);
  }

  Widget _buildView() {
    return View(
      width: width,
      margin: margin,
      height: height,
      padding: padding,
      child: _buildIcon(),
      decoration: decoration
    );
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