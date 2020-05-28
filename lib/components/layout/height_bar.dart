// import 'package:town/components/town.dart';

import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';

class HegihtBar extends StatelessWidget {
  final Color color;
  final double height;
  const HegihtBar({Key key, this.height, this.color = MyColor.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height == null ? 5 : height
    );
  }
}