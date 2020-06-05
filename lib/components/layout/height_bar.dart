// import 'package:town/components/town.dart';

import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';

class HegihtBar extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsetsGeometry margin;
  const HegihtBar({Key key, this.height, this.color = MyColor.backgroundColor, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: margin,
      height: height == null ? 5 : height
    );
  }
}