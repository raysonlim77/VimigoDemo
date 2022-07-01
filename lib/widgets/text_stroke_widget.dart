import 'package:flutter/material.dart';

class TextStrokeWidget extends StatefulWidget {
  String? text;

  String? fontFamily;
  bool overrideSizeStroke;
  double fontSize;
  double strokeWidth;
  Color strokeColor;
  List<Shadow>? shadow;
  Color color;

  TextStrokeWidget(
    this.text, {
    this.fontFamily,
    this.overrideSizeStroke = false,
    this.fontSize = 20,
    this.strokeWidth = 0, // stroke width default
    this.strokeColor = Colors.white,
    Key? key,
    this.shadow,
    this.color = Colors.black,
  }) : super(key: key) {
    if (this.shadow == null) this.shadow = [];

    // stroke to big right, let make automate little

    // this.overrideSizeStroke will disable automate .. so we can set our number
    if (this.strokeWidth != 0 && !this.overrideSizeStroke) {
      // this code will resize stroke so size will set 1/7 of font size, if stroke size is more than 1/7 font size
      // yeayy
      if (this.fontSize / 7 * 1 < this.strokeWidth)
        this.strokeWidth = this.fontSize / 7 * 1;
    }
  }

  @override
  State<TextStrokeWidget> createState() => _TextStrokeWidgetState();
}

class _TextStrokeWidgetState extends State<TextStrokeWidget> {
  @override
  Widget build(BuildContext context) {
    // to make a stroke text we need stack between 2 text..
    // 1 for text & one for stroke effect
    return Container(
      // width: context.isTablet ? fontSize* 0.3 : fontSize * 1.60,
      height: widget.fontSize * 7,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: EdgeInsets.all(constraints.maxHeight * 0.1),
            child: FittedBox(
              child: Stack(
                // redundant right?
                // same effect & lest code later.. :)
                children: List.generate(2, (index) {
                  // let declare style for text .. :)
                  // index == 0 for effect

                  TextStyle textStyle = index == 0
                      ? TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: this.widget.fontFamily,
                          fontSize: this.widget.fontSize,
                          shadows: this.widget.shadow,
                          fontWeight: FontWeight.w800,
                          foreground: Paint()
                            ..color = this.widget.strokeColor
                            ..strokeWidth = this.widget.strokeWidth
                            ..strokeCap = StrokeCap.round
                            ..strokeJoin = StrokeJoin.round
                            ..style = PaintingStyle.stroke,
                        )
                      : TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: this.widget.fontFamily,
                          fontSize: this.widget.fontSize,
                          color: this.widget.color,
                          fontWeight: FontWeight.w800,
                        );

                  // let disable stroke effect if this.strokeWidth == 0
                  return Offstage(
                    offstage: this.widget.strokeWidth == 0 &&
                        index ==
                            0, // put index == 0 so just disable effect only.. yeayy
                    child: Text(
                      this.widget.text!,
                      maxLines: 4,
                      style: textStyle,
                    ),
                  );
                }).toList(),
              ),

              //     Text(
              //   isEN ? "Student\'s Attendance" : "学生考勤",
              //   style: TextStyle(
              //       fontFamily:
              //           isEN ? "Riffic" : "PingFang-Bold",
              //       color: const Color(0xffffffff),
              //       fontSize: context.isTablet
              //           ? size.height * 0.012
              //           : size.width * 0.012,
              //       fontWeight: FontWeight.w100),
              //   maxLines: 2,
              //   textAlign: TextAlign.left,
              // )
            ),
          );
        },
      ),
    );
  }
}

class TextStrokeWidget2 extends StatefulWidget {
  String? text;
  double? width;
  double? height;

  String? fontFamily;
  bool overrideSizeStroke;
  double fontSize;
  double strokeWidth;
  Color strokeColor;
  List<Shadow>? shadow;
  Color color;

  TextStrokeWidget2(
    this.text, {
    this.width,
    this.height,
    this.fontFamily,
    this.overrideSizeStroke = false,
    this.fontSize = 20,
    this.strokeWidth = 0, // stroke width default
    this.strokeColor = Colors.white,
    Key? key,
    this.shadow,
    this.color = Colors.black,
  }) : super(key: key) {
    if (this.shadow == null) this.shadow = [];

    // stroke to big right, let make automate little

    // this.overrideSizeStroke will disable automate .. so we can set our number
    if (this.strokeWidth != 0 && !this.overrideSizeStroke) {
      // this code will resize stroke so size will set 1/7 of font size, if stroke size is more than 1/7 font size
      // yeayy
      if (this.fontSize / 7 * 1 < this.strokeWidth)
        this.strokeWidth = this.fontSize / 7 * 1;
    }
  }

  @override
  State<TextStrokeWidget2> createState() => _TextStrokeWidget2State();
}

class _TextStrokeWidget2State extends State<TextStrokeWidget2> {
  @override
  Widget build(BuildContext context) {
    // to make a stroke text we need stack between 2 text..
    // 1 for text & one for stroke effect
    return SizedBox(
      //color: Colors.purple,
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: Stack(
                // redundant right?
                // same effect & lest code later.. :)
                children: List.generate(2, (index) {
                  // let declare style for text .. :)
                  // index == 0 for effect

                  TextStyle textStyle = index == 0
                      ? TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: this.widget.fontFamily,
                          fontSize: this.widget.fontSize,
                          shadows: this.widget.shadow,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..color = this.widget.strokeColor
                            ..strokeWidth = this.widget.strokeWidth
                            ..strokeCap = StrokeCap.round
                            ..strokeJoin = StrokeJoin.round
                            ..style = PaintingStyle.stroke,
                        )
                      : TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: this.widget.fontFamily,
                          fontSize: this.widget.fontSize,
                          color: this.widget.color,
                          fontWeight: FontWeight.w800,
                        );

                  // let disable stroke effect if this.strokeWidth == 0
                  return Offstage(
                    offstage: this.widget.strokeWidth == 0 &&
                        index ==
                            0, // put index == 0 so just disable effect only.. yeayy
                    child: Text(
                      this.widget.text!,
                      maxLines: 4,
                      style: textStyle,
                    ),
                  );
                }).toList(),
              ),

              //     Text(
              //   isEN ? "Student\'s Attendance" : "学生考勤",
              //   style: TextStyle(
              //       fontFamily:
              //           isEN ? "Riffic" : "PingFang-Bold",
              //       color: const Color(0xffffffff),
              //       fontSize: context.isTablet
              //           ? size.height * 0.012
              //           : size.width * 0.012,
              //       fontWeight: FontWeight.w100),
              //   maxLines: 2,
              //   textAlign: TextAlign.left,
              // )
            ),
          );
        },
      ),
    );
  }
}
