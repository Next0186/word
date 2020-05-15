import 'package:flutter/material.dart';

class View extends StatelessWidget {
  final Color color;
  final Widget child;
  final double width;
  final double height;
  final Function onTap;
  final double overflow;
  final Matrix4 transform;
  final Decoration decoration;
  final EdgeInsetsGeometry margin;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;
  final Decoration foregroundDecoration;
  const View({
    Key key,
    this.child,
    this.color,
    this.width,
    this.onTap,
    this.height,
    this.margin,
    this.padding,
    this.overflow,
    this.alignment,
    this.transform,
    this.decoration,
    this.constraints,
    this.foregroundDecoration,
  }) : super(key: key);


  Widget _buildContainer() {
    return Container(
      child: child,
      color: color,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      transform: transform,
      alignment: alignment,
      decoration: decoration,
      constraints: constraints,
      foregroundDecoration: foregroundDecoration,
    ); 
  }

  Widget _buildView() {
    return overflow != null ? ClipRRect(
      borderRadius: BorderRadius.circular(overflow),
      child: _buildContainer(),
    ) : _buildContainer();
  }

  Widget _buildTapView() {
    return onTap != null ? InkWell(
      onTap: onTap,
      child: _buildView()
    ): _buildView();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTapView();
  }
}