import 'package:word/components/layout/color.dart';
import 'package:word/components/word.dart';

final ThemeData theme = ThemeData(
  accentColor: MyColor.accentColor, /// 前景色
  accentColorBrightness: Brightness.light, /// 用于确定放置在突出颜色顶部的文本和图标的颜色
  primarySwatch: Colors.blue,
  backgroundColor: MyColor.backgroundColor,
  primaryColor: MyColor.primaryColor, /// App主要部分的背景色
  bottomAppBarColor: MyColor.textColor, /// BottomAppBar的默认颜色
  brightness: Brightness.light, /// 类型，应用程序整体主题的亮度。 由按钮等Widget使用，以确定在不使用主色或强调色时要选择的颜色
  // buttonColor: MyColor.primaryColor,
  buttonTheme: ButtonThemeData(
    height: 45,
    buttonColor: MyColor.primaryColor,
    disabledColor: MyColor.disabledColor
  ),
  disabledColor: MyColor.disabledColor, /// 用于Widget无效的颜色，无论任何状态。例如禁用复选框
  hintColor: MyColor.hintColor, /// 用于提示文本或占位符文本的颜色
  indicatorColor: MyColor.primaryColor, /// TabBar中选项选中的指示器颜色。
  // textTheme: TextTheme(),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
    // labelStyle: TextStyle(fontSize: 14)
  ),
  cursorColor: MyColor.primaryColor, /// 光标颜色
  textSelectionColor: MyColor.primaryColor, /// 文本字段中选中文本的颜色
  textSelectionHandleColor: MyColor.primaryColor, /// 用于调整当前文本的哪个部分的句柄颜色
  scaffoldBackgroundColor: MyColor.backgroundColor, /// 作为Scaffold基础的Material默认颜色，典型Material应用或应用内页面的背景颜色
);