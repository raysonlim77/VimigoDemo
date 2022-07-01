import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String? text;

  String? fontFamily;
  bool overrideSizeStroke;
  double fontSize;
  double strokeWidth;
  Color strokeColor;
  List<Shadow>? shadow;
  Color color;

  TextWidget(
    this.text, {
    this.fontFamily,
    this.overrideSizeStroke = false,
    this.fontSize = 20,
    this.strokeWidth = 0,
    this.strokeColor = Colors.white,
    Key? key,
    this.shadow,
    this.color = Colors.black,
  }) : super(key: key) {
    if (this.shadow == null) this.shadow = [];

    if (this.strokeWidth != 0 && !this.overrideSizeStroke) {
      if (this.fontSize / 7 * 1 < this.strokeWidth)
        this.strokeWidth = this.fontSize / 7 * 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(2, (index) {
        TextStyle textStyle = index == 0
            ? TextStyle(
                decoration: TextDecoration.none,
                fontFamily: this.fontFamily,
                fontSize: this.fontSize,
                shadows: this.shadow,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..color = this.strokeColor
                  ..strokeWidth = this.strokeWidth
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round
                  ..style = PaintingStyle.stroke,
              )
            : TextStyle(
                decoration: TextDecoration.none,
                fontFamily: this.fontFamily,
                fontSize: this.fontSize,
                color: this.color,
                fontWeight: FontWeight.w800,
              );

        return Offstage(
          offstage: this.strokeWidth == 0 && index == 0,
          child: Text(
            this.text!,
            maxLines: 4,
            style: textStyle,
          ),
        );
      }).toList(),
    );
  }
}
